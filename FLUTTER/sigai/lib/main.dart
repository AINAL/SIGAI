import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'content.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SigaiApp());
}

class SigaiApp extends StatelessWidget {
  const SigaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIGAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const ContentView(),
    );
  }
}
