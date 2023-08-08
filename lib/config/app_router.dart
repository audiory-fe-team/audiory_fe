import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/screens/detail_story/detail_story_screen.dart';
import 'package:audiory_v0/screens/home/home_screen.dart';
import 'package:audiory_v0/screens/reading/reading_screen.dart';
import 'package:audiory_v0/screens/register/register_screen.dart';
import 'package:audiory_v0/screens/search/search_screen.dart';
import 'package:audiory_v0/screens/splash_screen/splash_screen.dart';
import 'package:audiory_v0/screens/writer_screens/writing/writing_screen.dart';
import 'package:audiory_v0/services/auth_services.dart';
import 'package:audiory_v0/screens/home_test/profile_screen_test.dart';
import 'package:audiory_v0/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//auth
import "package:firebase_auth/firebase_auth.dart";

class AppRoutes {
  static final GoRouter routes = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    errorBuilder: (context, state) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        routes.go('/');
      });

      //you must return a widget anyway
      return const SizedBox.shrink();
    },
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return HomeScreeen();
        },
      ),
      GoRoute(
        path: '/search',
        builder: (BuildContext context, GoRouterState state) {
          return SearchScreen();
        },
      ),
      GoRoute(
        path: '/writer',
        builder: (BuildContext context, GoRouterState state) {
          return const WritingScreen();
        },
      ),
      GoRoute(
          path: '/story/:storyId',
          builder: (BuildContext context, GoRouterState state) {
            return SearchScreen();
          },
          routes: [
            GoRoute(
              path: 'chapter/:chapterId',
              builder: (BuildContext context, GoRouterState state) {
                return ReadingScreen();
              },
            )
          ]),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        name: 'register',
        path: '/register',
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        name: 'detailStory',
        path: '/detailStory/:storyId',
        builder: (BuildContext context, GoRouterState state) {
          final storyId = state.pathParameters['storyId']!;
          print(storyId);
          // print('id' + id);
          return DetailStoryScreen(
            id: storyId,
          );
        },
      ),
      GoRoute(
        name: 'profile',
        path: '/profile',
        builder: (_, GoRouterState state) {
          return const ProfileScreenTest();
        },
        redirect: _redirect,
      ),
    ],
  );

  static String? _redirect(BuildContext context, GoRouterState state) {
    final User? user = Auth().currentUser;
    print(user != null);
    // return user != null ? null : context.namedLocation('/login');
    return user != null
        ? null
        : Uri(
            path: '/login',
            queryParameters: {'redirect_to': state.location},
          ).toString();
  }
}
