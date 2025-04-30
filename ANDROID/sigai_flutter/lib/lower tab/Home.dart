import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPremiumUser = false;
  bool isDarkMode = false;
  String appLanguage = 'ms';
  bool showSetting = false;

  @override
  Widget build(BuildContext context) {
    final bool dark = isDarkMode || Theme.of(context).brightness == Brightness.dark;

    final headerGradient = LinearGradient(
      colors: dark
          ? [const Color(0xFF323264), const Color(0xFF505096)]
          : [const Color(0xFFFFCCE5), const Color(0xFFD2F0FF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: dark
                    ? [Colors.black, Colors.black, Colors.grey]
                    : [
                        const Color(0xFFEbfaff),
                        const Color(0xFFEbfaff),
                        const Color(0xFFDCF5FF),
                        Colors.white,
                        Colors.white,
                        const Color(0xFFFFDCE6),
                        const Color(0xFFFFDCE6),
                      ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => showSetting = !showSetting),
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        gradient: headerGradient,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          if (!dark)
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.2),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        appLanguage == 'ms' ? 'Selamat Datang' : 'Welcome',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: dark ? Colors.yellow : Colors.blue,
                          shadows: dark
                              ? [const Shadow(color: Colors.black26, blurRadius: 2)]
                              : [],
                        ),
                      ),
                    ),
                  ),
                  if (showSetting)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          _buildSettingButton(Icons.edit_note, 'Tutorial'),
                          _buildSettingButton(Icons.book, appLanguage == 'ms' ? 'Sejarah' : 'History'),
                          _buildSettingButton(Icons.description, 'SIGAI.pdf'),
                          _buildSettingButton(Icons.settings, appLanguage == 'ms' ? 'Tetapan' : 'Settings'),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                  _buildSection(
                    title: appLanguage == 'ms' ? 'Tentang SIGAI' : 'About SIGAI',
                    description: appLanguage == 'ms'
                        ? 'SIGAI ialah kaedah inovatif untuk memudahkan operasi darab dan bahagi menggunakan garisan dan simbol visual...'
                        : 'SIGAI is an innovative method that simplifies multiplication and division using visual lines and symbols...',
                  ),
                  _buildSection(
                    title: appLanguage == 'ms' ? 'Belajar & Praktis di Mod Belajar' : 'Learn & Practice in Learning Mode',
                    description: appLanguage == 'ms'
                        ? 'Gunakan Mod Belajar untuk berlatih dan memahami konsep darab dan bahagi dengan lebih mudah.'
                        : 'Use Learning Mode to practice and understand multiplication and division concepts more easily.',
                  ),
                  _buildSection(
                    title: appLanguage == 'ms' ? 'Kejayaan SIGAI' : 'SIGAI Success Stories',
                    description: appLanguage == 'ms'
                        ? 'SIGAI telah membantu ramai pelajar berjaya dalam matematik. Ketahui kisah mereka dengan melihat sejarah pembelajaran.'
                        : 'SIGAI has helped many students succeed in mathematics. Discover their stories by exploring the learning history.',
                  ),
                  if (!isPremiumUser)
                    Container(
                      height: 50,
                      margin: const EdgeInsets.only(top: 20),
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: const Text('Banner Ad Placeholder'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingButton(IconData icon, String label) {
    final bool dark = isDarkMode || Theme.of(context).brightness == Brightness.dark;
    Color bgColor;

    if (label.contains('Tutorial')) {
      bgColor = dark ? const Color(0xFF993344) : const Color(0xFFFFB3BA);
    } else if (label.contains('Sejarah') || label.contains('History')) {
      bgColor = dark ? const Color(0xFF4D9966) : const Color(0xFFBAFFC9);
    } else if (label.contains('SIGAI')) {
      bgColor = dark ? const Color(0xFF996633) : const Color(0xFFFFDDBA);
    } else {
      bgColor = dark ? const Color(0xFF4D6699) : const Color(0xFFBAE1FF);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          foregroundColor: dark ? Colors.white : Colors.black,
          backgroundColor: bgColor,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String description}) {
    final bool dark = isDarkMode || Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: dark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 15,
              color: dark ? Colors.white70 : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
