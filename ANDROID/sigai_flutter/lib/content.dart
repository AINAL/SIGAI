import 'package:flutter/material.dart';
import 'package:sigai_flutter/lower%20tab/AI.dart';
import 'package:sigai_flutter/lower%20tab/Bahagi.dart';
import 'package:sigai_flutter/lower%20tab/Mode.dart';
import 'lower tab/Darab.dart';
import 'lower tab/Home.dart';
import 'uppert tab/cloudShape.dart';


class ContentView extends StatefulWidget {
  const ContentView({super.key});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> with TickerProviderStateMixin {
  bool showSplash = true;
  bool isDarkMode = false;
  String appLanguage = 'ms';
  int selectedTab = 0;

  late final AnimationController _backCloudController;
  late final AnimationController _midCloudController;
  late final AnimationController _frontCloudController;
  late final AnimationController _starController;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => showSplash = false);
    });

    _backCloudController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    _midCloudController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true);

    _frontCloudController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(reverse: true);

    _starController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _backCloudController.dispose();
    _midCloudController.dispose();
    _frontCloudController.dispose();
    _starController.dispose();
    super.dispose();
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
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Background gradient (light mode only)
                      if (!isDarkMode)
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFFFFDCE6),
                                  const Color(0xFFFFDCE6),
                                  Colors.white,
                                  Colors.white,
                                  const Color(0xFFDCF5FF),
                                  const Color(0xFFEbfaff),
                                  const Color(0xFFEbfaff),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                      // CloudShapeBPainter (back cloud)
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: _backCloudController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(30 * _backCloudController.value, 0),
                              child: CustomPaint(painter: CloudShapeBPainter(isDarkMode: isDarkMode)),
                            );
                          },
                        ),
                      ),
                      // StarScatterPainter in dark mode, animated with its own controller
                      if (isDarkMode)
                        Positioned.fill(
                          child: AnimatedBuilder(
                            animation: _starController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(4 * _starController.value, 0),
                                child: CustomPaint(
                                  painter: StarScatterPainter(color: Colors.yellow),
                                ),
                              );
                            },
                          ),
                        ),
                      // CloudShapeMPainter (mid cloud)
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: _midCloudController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(-50 * _midCloudController.value, 0),
                              child: CustomPaint(painter: CloudShapeMPainter(isDarkMode: isDarkMode)),
                            );
                          },
                        ),
                      ),
                      // CloudShapeFPainter (front cloud)
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: _frontCloudController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(4 * _frontCloudController.value, 0),
                              child: CustomPaint(painter: CloudShapeFPainter(isDarkMode: isDarkMode)),
                            );
                          },
                        ),
                      ),
                      // Logo/Row
                      Container(
                        height: 120,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Spacer(),
                            // Add vertical space between clouds and logo row
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showLanguagePicker();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Image.asset(
                                      isDarkMode ? 'assets/sigai_dark.png' : 'assets/sigai_light.png',
                                      width: 110,
                                      height: 100,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: Icon(
                                    isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                                    size: 50,
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
                          ],
                        ),
                      ),
                    ],
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
        return const HomeScreen();
      case 1:
        return const DarabPage();
      case 2:
        return const ModePage();
      case 3:
        return const BahagiPage();
      case 4:
        return const AiPage();
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
