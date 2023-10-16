import 'dart:developer';

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
      title: 'Hive Mobile App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hive Mobile App - Home Page'),
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
      body: const Center(
        child: Text('Hello World from Hive Mobile App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          const platform = MethodChannel('app.the-hive-mobile/bridge');
          var id = 'getChainProps_${DateTime.now().toIso8601String()}';
          final String response = await platform.invokeMethod('getChainProps', {
            'id': id,
          });
          log('Response received from platform is - $response');
        },
        child: const Icon(Icons.bolt),
      ),
    );
  }
}
