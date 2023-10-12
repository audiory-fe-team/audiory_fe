import 'package:audiory_v0/config/app_router.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/theme/theme_manager.dart';

import 'package:flutter/material.dart';
//auth
import "package:firebase_core/firebase_core.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fquery/fquery.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just_audio_background/just_audio_background.dart';

final queryClient = QueryClient(
  defaultQueryOptions: DefaultQueryOptions(),
);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true);

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBEdfyQ4SuEt3OBGTqoa5Xgv6QzPm4K960",
      appId: "1:1067039909340:android:18b29a66bcd8dbb6961b19",
      projectId: "audioryauth",
      messagingSenderId: "",
    ),
  );

  runApp(QueryClientProvider(
    queryClient: queryClient,
    child: ProviderScope(child: MyApp()),
  ));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _themeNotifier = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Audiory app',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeNotifier.themeMode,
      routerConfig: AppRoutes.routes,
    );
  }
}
