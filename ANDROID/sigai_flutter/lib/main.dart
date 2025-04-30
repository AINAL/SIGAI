import 'package:flutter/material.dart';
import 'content.dart';

void main() {
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
