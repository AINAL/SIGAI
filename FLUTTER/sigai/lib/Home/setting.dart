import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool showDeleteAlert = false;

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          const ListTile(title: Text("Legal & Compliance", style: TextStyle(fontWeight: FontWeight.bold))),
          ListTile(
            title: const Text("Privacy Policy"),
            onTap: () => _launchURL("https://sigai-backend.web.app/privacy-policy.html"),
          ),
          ListTile(
            title: const Text("Terms of Use"),
            onTap: () => _launchURL("https://sigai-backend.web.app/term-of-use.html"),
          ),
          ListTile(
            title: const Text("AI Disclaimer"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AIDisclaimerView()),
              );
            },
          ),
          const Divider(),
          const ListTile(title: Text("Data & Privacy", style: TextStyle(fontWeight: FontWeight.bold))),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "This app uses Google Gemini API to process user inputs. Some data may be collected and stored temporarily for AI functionality. No personally identifiable information is stored or shared.",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          ListTile(
            title: const Text("Request Data Deletion", style: TextStyle(color: Colors.red)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Data Deletion Request"),
                  content: const Text("If you want to request data deletion, please contact support at ainalsyazwan@gmail.com"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(),
          const ListTile(title: Text("App Info", style: TextStyle(fontWeight: FontWeight.bold))),
          ListTile(
            title: const Text("Version"),
            trailing: Text("1.0", style: TextStyle(color: Colors.grey[600])),
          ),
        ],
      ),
    );
  }
}

class AIDisclaimerView extends StatelessWidget {
  const AIDisclaimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Disclaimer")),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "This app uses AI-generated content. Responses may not always be accurate. Please verify any critical information before relying on AI-generated results.",
        ),
      ),
    );
  }
}
