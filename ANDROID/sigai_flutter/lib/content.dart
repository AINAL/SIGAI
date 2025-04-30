import 'package:flutter/material.dart';

class ContentView extends StatefulWidget {
  const ContentView({super.key});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  bool showSplash = true;
  bool isDarkMode = false;
  String appLanguage = 'ms';
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => showSplash = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        body: Stack(
          children: [
            if (showSplash)
              const Center(
                child: Text(
                  "SIGAI",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              )
            else
              Column(
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showLanguagePicker();
                          },
                          child: Image.asset(
                            isDarkMode
                                ? 'assets/Sigai-removebg-preview-2.png'
                                : 'assets/Sigai-removebg-preview.png',
                            width: 100,
                            height: 50,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                            color: isDarkMode ? Colors.yellow : Colors.orange,
                          ),
                          onPressed: () {
                            setState(() {
                              isDarkMode = !isDarkMode;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: _getCurrentTab()),
                ],
              ),
          ],
        ),
        bottomNavigationBar: showSplash
            ? null
            : BottomNavigationBar(
                currentIndex: selectedTab,
                onTap: (index) {
                  setState(() {
                    selectedTab = index;
                  });
                },
                selectedItemColor: isDarkMode ? Colors.yellow : Colors.blue,
                unselectedItemColor: Colors.grey,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: appLanguage == 'ms' ? 'Laman Utama' : 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.close),
                    label: appLanguage == 'ms' ? 'Darab' : 'Multiply',
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.book),
                    label: appLanguage == 'ms' ? 'Mod Berpandu' : 'Guided Mode',
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.horizontal_split),
                    label: appLanguage == 'ms' ? 'Bahagi' : 'Divide',
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.psychology),
                    label: appLanguage == 'ms' ? 'Tanya SIGAI' : 'Ask SIGAI',
                  ),
                ],
              ),
      ),
    );
  }

  Widget _getCurrentTab() {
    switch (selectedTab) {
      case 0:
        return const Center(child: Text('Home Page'));
      case 1:
        return const Center(child: Text('Darab Page'));
      case 2:
        return const Center(child: Text('Guided Mode Page'));
      case 3:
        return const Center(child: Text('Bahagi Page'));
      case 4:
        return const Center(child: Text('Tanya SIGAI Page'));
      default:
        return const SizedBox.shrink();
    }
  }

  void _showLanguagePicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  appLanguage = 'ms';
                });
                Navigator.pop(context);
              },
              child: const Text("🇲🇾 Malay"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  appLanguage = 'en';
                });
                Navigator.pop(context);
              },
              child: const Text("🇬🇧 English"),
            ),
          ],
        ),
      ),
    );
  }
}
