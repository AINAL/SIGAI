const { onRequest } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const prePrompt = require("./prompt");

const GEMINI_API_KEY = defineSecret("GEMINI_API_KEY");
const GEMINI_API_FREE = defineSecret("GEMINI_API_FREE");

exports.askAI = onRequest({ secrets: [GEMINI_API_KEY, GEMINI_API_FREE] }, async (req, res) => {
  const userPrompt = req.body.prompt;

  async function callGeminiAPI(apiKey, modelUrl, prompt, controller = null) {
    controller = controller || new AbortController();
    const timeout = setTimeout(() => controller.abort(), 8000); // 8 seconds timeout

    try {
      const response = await fetch(`${modelUrl}?key=${apiKey}`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          contents: [{ parts: [{ text: prePrompt + "\n\n" + prompt }] }]
        }),
        signal: controller.signal
      });

      clearTimeout(timeout);

      const text = await response.text();

      try {
        const data = JSON.parse(text);
        console.log("🔍 Gemini API raw response:", JSON.stringify(data));
        return data.candidates?.[0]?.content?.parts?.[0]?.text ?? null;
      } catch (parseErr) {
        console.error("❌ Failed to parse JSON:", parseErr.message);
        console.error("💬 Raw response:", text);
        return null;
      }
    } catch (err) {
      clearTimeout(timeout);
      console.error("❌ Gemini fetch failed:", err.message);
      return null;
    }
  }

  let aiReply = null;

  function withTimeout(promiseFn, ms) {
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), ms);
    return Promise.race([
      promiseFn(controller),
      new Promise((_, reject) => setTimeout(() => reject(new Error("timeout")), ms))
    ]).finally(() => clearTimeout(timeout));
  }

  try {
    const freeKey = process.env.GEMINI_API_FREE;
    const freeModel = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-04-17:generateContent";
    const paidKey = process.env.GEMINI_API_KEY;
    const paidModel = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-lite:generateContent";

    try {
      aiReply = await withTimeout((ctrl) =>
        callGeminiAPI(freeKey, freeModel, userPrompt, ctrl), 5000);
      console.log("🚀 Fast Free API reply:", aiReply);

      if (!aiReply) {
        console.warn("⚠️ Free API returned null, using Paid fallback");
        aiReply = await callGeminiAPI(paidKey, paidModel, userPrompt);
        console.log("💰 Paid API reply:", aiReply);
      }
    } catch {
      console.warn("⏱️ Free API timeout or error, using Paid fallback");
      aiReply = await callGeminiAPI(paidKey, paidModel, userPrompt);
      console.log("💰 Paid API reply:", aiReply);
    }

    if (!aiReply) {
      console.error("❌ aiReply is null or empty");
      return res.status(200).send({ result: "Maaf, AI tidak dapat memberi jawapan sekarang. Sila cuba lagi sebentar nanti." });
    }

    console.log("✅ AI reply:", aiReply);
    res.status(200).send({ result: aiReply });

  } catch (err) {
    console.error("🔥 Gemini Function Error:", err.message);
    res.status(500).send({ error: "AI failed to respond" });
  }
});
