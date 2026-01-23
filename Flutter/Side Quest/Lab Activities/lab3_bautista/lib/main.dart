import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zeus Pogi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
      ),
      home: const MyHomePage(title: 'Gay Dating App!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 8),
              const Text(
                'Hello, my fellow gay dudes!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              const CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(
                  'https://cdn-useast1.kapwing.com/static/templates/black-guy-hiding-behind-tree-meme-template-full-80d771c5.webp',
                ),
                backgroundColor: Colors.transparent,
              ),

              const SizedBox(height: 16),

              Text(
                "I'm Zeus Bautista — a 3rd-year I.T. student at National University Dasmariñas, focused on full-cycle application development.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sir, tapos na po...')),
                  );
                },
                child: const Text('Say "Hi"'),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.star, color: Colors.amber, size: 28),
                  Icon(Icons.star, color: Colors.amber, size: 28),
                  Icon(Icons.star, color: Colors.amber, size: 28),
                  Icon(Icons.star, color: Colors.amber, size: 28),
                  Icon(Icons.star_half_sharp, color: Colors.amber, size: 28),
                  SizedBox(width: 12),
                ],
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Exiting...')));
                },
                child: const Text('Exit App'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
