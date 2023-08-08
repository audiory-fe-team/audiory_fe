import 'package:audiory_v0/config/app_router.dart';
import 'package:audiory_v0/services/auth_services.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/theme/theme_manager.dart';

import 'package:flutter/material.dart';
//auth
import "package:firebase_core/firebase_core.dart";
import 'package:provider/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBEdfyQ4SuEt3OBGTqoa5Xgv6QzPm4K960",
      appId: "1:1067039909340:android:18b29a66bcd8dbb6961b19",
      projectId: "audioryauth",
      messagingSenderId: "",
    ),
  );
  runApp(const ProviderScope(child: MyApp()));
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // late final _router = GoRouter(routes: _routesBuilder, error: _errorBuilder);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Audiory app',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      routerConfig: AppRoutes.routes,
    );
  }
}
