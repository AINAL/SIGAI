import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigAPIKey {
  /// Retrieve API Key
  static Future<String?> getAPIKey() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.fetchAndActivate();
      final apiKey = remoteConfig.getString('API_KEY');
      if (apiKey.isEmpty) {
        print('❌ Remote Config: API_KEY is empty');
        return null;
      }
      return apiKey;
    } catch (e) {
      print('❌ Failed to fetch API Key from Remote Config: $e');
      return null;
    }
  }
}

// Usage in API Calls
Future<void> exampleUsage() async {
  final apiKey = await RemoteConfigAPIKey.getAPIKey() ?? 'Error: API Key Not Found';
  print(apiKey);
}
