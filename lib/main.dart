import 'package:flutter/material.dart';
import 'package:hive_mobile_app/resources/enum.dart';
import 'package:hive_mobile_app/services/api_service.dart';
import 'package:hive_mobile_app/views/home/home_view.dart';

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
      home: const HomeView(),
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
          ApiService().getChainProps();
          ApiService().getFeed(FeedType.trending);
        },
        child: const Icon(Icons.bolt),
      ),
    );
  }
}
