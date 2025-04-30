import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}