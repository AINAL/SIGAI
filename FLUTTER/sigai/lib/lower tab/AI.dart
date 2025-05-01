import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:sigai_flutter/AI/getAIresponse.dart' show RemoteConfigAPIKey;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigai_flutter/AI/training.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AnimatedDots extends StatefulWidget {
  const AnimatedDots({super.key});

  @override
  _AnimatedDotsState createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _dots;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
    _dots = IntTween(begin: 1, end: 3).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _dots,
      builder: (_, __) {
        String dots = '.' * _dots.value;
        return Text(
          'typing$dots',
          style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
        );
      },
    );
  }
}

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

  String aiAnimatedText = '';

  // Tambah state untuk mesej dan controller
  List<Map<String, String>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool isTyping = false;

  @override
  void initState() {
    super.initState();
    appLanguage = widget.appLanguage;
    _loadQuestionCount();
  }

  Future<void> _loadQuestionCount() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T').first;
    final storedDate = prefs.getString('questionDate');
    if (storedDate != today) {
      await prefs.setInt('aiQuestionCount', 0);
      await prefs.setString('questionDate', today);
      setState(() {
        aiQuestionCount = 0;
      });
    } else {
      final count = prefs.getInt('aiQuestionCount') ?? 0;
      setState(() {
        aiQuestionCount = count;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  List<InlineSpan> _buildTextSpansWithLinks(String text, bool dark) {
    final List<InlineSpan> spans = [];
    final RegExp linkRegExp = RegExp(r'(https?:\/\/[^\s]+)');
    final matches = linkRegExp.allMatches(text);

    int lastMatchEnd = 0;

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: TextStyle(color: dark ? Colors.white : Colors.black),
        ));
      }
      final url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
            },
        ),
      );
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd),
        style: TextStyle(color: dark ? Colors.white : Colors.black),
      ));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = isDarkMode || Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Column(
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
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isUser = message["sender"] == "user";
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 4.0,
                        bottom: index == messages.length - 1 ? 0.0 : 4.0,
                      ),
                      child: Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 250),
                          padding: isUser
                              ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
                              : const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: isUser
                                ? (dark ? Colors.pink[300] : Colors.pink[100])
                                : (dark ? Colors.deepPurple[300] : Colors.lightBlueAccent[100]),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: Radius.circular(isUser ? 16 : 0),
                              bottomRight: Radius.circular(isUser ? 0 : 16),
                            ),
                          ),
                          child: message["text"] == "typing..."
                            ? AnimatedDots()
                            : !isUser && message["text"] != null && message["text"]!.contains("Kouta harian anda sudah habis")
                              ? RichText(
                                  text: TextSpan(
                                    style: TextStyle(color: dark ? Colors.white : Colors.black),
                                    children: [
                                      const TextSpan(
                                        text: "Kouta harian anda sudah habis. Pilih salah satu:\n\n",
                                      ),
                                      TextSpan(
                                        text: "👉 Tonton Iklan\n",
                                        style: const TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Handle watch ad action
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Tonton Iklan clicked')),
                                            );
                                          },
                                      ),
                                      TextSpan(
                                        text: "👉 Langgan Premium",
                                        style: const TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold, color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Handle subscribe premium action
                                            setState(() {
                                              showPurchaseOptions = true;
                                            });
                                          },
                                      ),
                                    ],
                                  ),
                                  textHeightBehavior: const TextHeightBehavior(
                                    applyHeightToFirstAscent: false,
                                    applyHeightToLastDescent: false,
                                  ),
                                  strutStyle: const StrutStyle(forceStrutHeight: true, height: 1.2),
                                )
                              : SelectableText.rich(
                                  TextSpan(
                                    children: _buildTextSpansWithLinks(message["text"] ?? '', dark),
                                  ),
                                  textAlign: TextAlign.left,
                                  textWidthBasis: TextWidthBasis.parent,
                                  textHeightBehavior: const TextHeightBehavior(
                                    applyHeightToFirstAscent: false,
                                    applyHeightToLastDescent: false,
                                  ),
                                  strutStyle: const StrutStyle(forceStrutHeight: true, height: 1.2),
                                ),
                        ),
                      ),
                    );
                  },
                ),
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
                        hintStyle: TextStyle(color: dark ? Colors.white70 : Colors.black45),
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: dark ? Colors.deepPurple[100] : Colors.pink[50],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: isTyping ? null : () async {
                      if (isTyping) return;

                      final userInput = _controller.text.trim();
                      if (userInput.isEmpty) return;

                      if (!isPremiumUser && aiQuestionCount >= 10) {
                        setState(() {
                          messages.add({"sender": "user", "text": userInput});
                          messages.add({
                            "sender": "ai",
                            "text": "Kouta harian anda sudah habis. Pilih salah satu:\n\n"
                                "👉 <u><b>Tonton Iklan</b></u>\n"
                                "👉 <u><b>Langgan Premium</b></u>"
                          });
                        });
                        _scrollToBottom();
                        return;
                      }

                      setState(() {
                        aiQuestionCount++;
                        messages.add({"sender": "user", "text": userInput});
                        _controller.clear();
                        messages.add({"sender": "ai", "text": "typing..."});
                        isTyping = true;
                      });
                      SharedPreferences.getInstance().then((prefs) {
                        prefs.setInt('aiQuestionCount', aiQuestionCount);
                      });
                      _scrollToBottom();

                      getAIResponse(userInput).then((aiResponse) async {
                        aiAnimatedText = '';
                        setState(() {
                          messages.removeWhere((msg) => msg["sender"] == "ai" && msg["text"] == "typing...");
                          messages.add({"sender": "ai", "text": ""});
                        });
                        _scrollToBottom();
                        for (int i = 0; i < aiResponse.length; i++) {
                          await Future.delayed(const Duration(milliseconds: 20));
                          setState(() {
                            aiAnimatedText += aiResponse[i];
                            messages[messages.length - 1]["text"] = aiAnimatedText;
                          });
                          _scrollToBottom();
                        }
                        setState(() {
                          isTyping = false;
                        });
                      }).catchError((e) {
                        setState(() {
                          messages.removeWhere((msg) => msg["sender"] == "ai" && msg["text"] == "typing...");
                          messages.add({
                            "sender": "ai",
                            "text": "Maaf, saya sedang sibuk sekarang. Cuba tanya semula sebentar lagi ya 😊"
                          });
                          isTyping = false;
                        });
                        _scrollToBottom();
                      });
                    },
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}

Future<String> getAIResponse(String prompt) async {
  final apiKey = await RemoteConfigAPIKey.getAPIKey();
  if (apiKey == null) return 'API Key not found. Please set it in settings.';

  final url = Uri.parse(
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',
  );

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'contents': [
        {
          'parts': [
            {'text': "$systemMessageAll\n\n$prompt"}
          ]
        }
      ]
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
    return text ?? 'Empty response from Gemini.';
  } else {
    return 'Error ${response.statusCode}: ${response.reasonPhrase}';
  }
}