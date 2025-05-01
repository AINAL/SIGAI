import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sigai_flutter/AI/getAIresponse.dart' show RemoteConfigAPIKey;
import 'package:http/http.dart' as http;

class AiPage extends StatefulWidget {
  final String appLanguage;
  const AiPage({super.key, required this.appLanguage});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  bool isDarkMode = false;
  bool isPremiumUser = false;
  int aiQuestionCount = 0;
  bool showPurchaseOptions = false;
  late String appLanguage;

  // Tambah state untuk mesej dan controller
  List<Map<String, String>> messages = [
    {"sender": "ai", "text": "Hai! Ada apa nak saya bantu hari ni?"},
  ]; // {"sender": "user"/"ai", "text": "..."}
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    appLanguage = widget.appLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = isDarkMode || Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  showPurchaseOptions = !showPurchaseOptions;
                });
              },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: dark
                        ? [const Color(0xFF323264), const Color(0xFF505096)]
                        : [const Color(0xFFFFD6EC), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'AI SIGAI',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: dark ? Colors.yellow : const Color(0xFFFF4D88),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isPremiumUser
                          ? 'Unlimited questions (Premium)'
                          : '${10 - aiQuestionCount} free questions left today',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFFFB6C1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!isPremiumUser && showPurchaseOptions)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Unlock not implemented')),
                        );
                      },
                      icon: const Icon(Icons.lock_open),
                      label: const Text("Unlock Unlimited AI"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dark ? Colors.deepPurple : Colors.lightBlueAccent,
                        foregroundColor: dark ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        minimumSize: const Size.fromHeight(44),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Restore not implemented')),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text("Restore Purchases"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dark ? Colors.teal : Colors.greenAccent,
                        foregroundColor: dark ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        minimumSize: const Size.fromHeight(44),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            Container(
              height: 450,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isUser = message["sender"] == "user";
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Align(
                      alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 250),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isUser
                              ? (dark ? Colors.deepPurple : Colors.pink[100])
                              : (dark ? Colors.teal : Colors.lightBlueAccent),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message["text"] ?? '',
                          style: TextStyle(color: dark ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                 Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ask something...',
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: dark ? Colors.deepPurple[100] : Colors.pink[50],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final userInput = _controller.text.trim();
                      if (userInput.isEmpty) return;

                      setState(() {
                        messages.add({"sender": "user", "text": userInput});
                        _controller.clear();
                      });

                      getAIResponse(userInput).then((aiResponse) {
                        setState(() {
                          messages.add({"sender": "ai", "text": aiResponse});
                        });
                      });
                    },
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> getAIResponse(String prompt) async {
  // Dummy API call simulation — replace this with real HTTP request to your AI backend
  await Future.delayed(const Duration(seconds: 1));
  final apiKey = await RemoteConfigAPIKey.getAPIKey();
  if (apiKey == null) return 'API Key not found. Please set it in settings.';

  final url = Uri.parse('https://your-api-endpoint.com/chat'); // Ganti dengan endpoint sebenar
  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'prompt': prompt,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['response'] ?? 'No response from AI.';
  } else {
    return 'Error: ${response.statusCode} ${response.reasonPhrase}';
  }
}