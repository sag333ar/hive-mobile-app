import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_mobile_app/core/utilities/routes/app_router.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/services/data_service/api_service.dart';
import 'core/dependency_injection/dependency_injection.dart' as get_it;

void main()async{
  await get_it.init();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'Hive Mobile App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
