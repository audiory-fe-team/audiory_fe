import 'dart:io';

import 'package:audiory_v0/config/app_router.dart';
import 'package:audiory_v0/providers/global_me_provider.dart';
import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/theme/theme_manager.dart';

import 'package:flutter/material.dart';
//auth
import "package:firebase_core/firebase_core.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fquery/fquery.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'dart:ui' as ui;

final queryClient = QueryClient(
  defaultQueryOptions: DefaultQueryOptions(),
);

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

//Turn off red alert
  RenderErrorBox.backgroundColor = Colors.transparent;
  RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);

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

  HttpOverrides.global = MyHttpOverrides();
  runApp(QueryClientProvider(
    queryClient: queryClient,
    child:
        ProviderScope(child: SkeletonizerScope(enabled: true, child: MyApp())),
  ));
}

class MyApp extends ConsumerWidget {
  setUserInfoProvider(WidgetRef ref) async {
    try {
      final res = await AuthRepository().getMyInfo();
      ref.read(globalMeProvider.notifier).setUser(res);
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _themeNotifier = ref.watch(themeNotifierProvider);

    setUserInfoProvider(ref);

    return SkeletonizerConfig(
        data: _themeNotifier.themeMode == ThemeMode.light
            ? const SkeletonizerConfigData.light()
            : const SkeletonizerConfigData.dark(),
        child: MaterialApp.router(
          locale: const Locale('vi', ''), // Set the locale to Vietnamese
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('vi', ''), // Vietnamese
            // Add other supported locales here
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: 'Audiory',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: _themeNotifier.themeMode,
          routerConfig: AppRoutes.routes,
        ));
  }
}
///
