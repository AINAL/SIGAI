import 'package:flutter/material.dart';

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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          const Text(
            'Selamat Datang ke SIGAI',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/sigai_logo.png'), // make sure you add this image
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DarabPage()),
                  );
                },
                child: const Text('Darab'),
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Bahagi')),
              ElevatedButton(onPressed: () {}, child: const Text('Mula')),
              ElevatedButton(onPressed: () {}, child: const Text('Sejarah')),
              ElevatedButton(onPressed: () {}, child: const Text('Tetapan')),
            ],
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Versi Android (Beta)',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class DarabPage extends StatelessWidget {
  const DarabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Darab')),
      body: const Center(
        child: Text(
          'Ini adalah skrin Darab',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
