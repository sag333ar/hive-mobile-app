import 'dart:developer';

import 'package:auth/core/configs/get_it.dart';
import 'package:auth/feature/user/view/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_mobile_app/core/services/data_service/api_service.dart';
import 'package:hive_mobile_app/core/utilities/app_scroll_behaviour.dart';
import 'package:hive_mobile_app/core/utilities/enum.dart';
import 'package:hive_mobile_app/core/utilities/routes/app_router.dart';
import 'package:hive_mobile_app/core/utilities/theme/theme_mode.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'core/dependency_injection/dependency_injection.dart' as get_it;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await get_it.init();
  await GetStorage.init();
  await Config.init(getItInstance: get_it.getIt);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _currentUser = UserController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeController()),
        ChangeNotifierProvider.value(value: _currentUser)
      ],
      child: Consumer<ThemeController>(
        builder: (context, themeController, child) {
          return MaterialApp.router(
            routerConfig: AppRouter(_currentUser).router,
            title: 'Hive Mobile App',
            scrollBehavior: AppScrollBehavior(),
            theme: themeController.getLightTheme(),
            darkTheme: themeController.getDarkTheme(),
            themeMode: themeController.themeMode,
            debugShowCheckedModeBanner: false,
          );
        },
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
