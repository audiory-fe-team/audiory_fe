import 'package:audiory_v0/feat-explore/utils/ranking.dart';
import 'package:audiory_v0/feat-explore/models/ranking.dart';
import 'package:audiory_v0/feat-explore/screens/explore_screen.dart';
import 'package:audiory_v0/feat-explore/screens/ranking_screen.dart';
import 'package:audiory_v0/feat-explore/screens/result_screen.dart';
import 'package:audiory_v0/feat-explore/screens/search_screen.dart';
import 'package:audiory_v0/feat-explore/screens/home_screen.dart';
import 'package:audiory_v0/feat-write/screens/layout/compose_chapter_screen.dart';
import 'package:audiory_v0/feat-write/screens/layout/compose_screen.dart';
import 'package:audiory_v0/feat-write/screens/writer_screen.dart';
import 'package:audiory_v0/layout/main_layout.dart';
import 'package:audiory_v0/feat-read/detail_story_screen.dart';
import 'package:audiory_v0/screens/reading/reading_screen.dart';
import 'package:audiory_v0/screens/register/register_screen.dart';
import 'package:audiory_v0/screens/splash_screen/splash_screen.dart';

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
          // return AnimatedSplashScreen(
          //     duration: 3000,
          //     splash: SplashScreen(),
          //     nextScreen: AppMainLayout(),
          //     splashTransition: SplashTransition.fadeTransition,
          //     pageTransitionType: PageTransitionType.scale,
          //     backgroundColor: Colors.white);
          return const AppMainLayout();
        },
      ),
      GoRoute(
        name: 'ranking',
        path: '/ranking',
        builder: (BuildContext context, GoRouterState state) {
          final typeString = state.queryParameters["type"];
          RankingType type = mapStringToRankingType(typeString);
          final metricString = state.queryParameters["metric"];
          RankingMetric metric = mapStringToRankingMetric(metricString);
          final timeString = state.queryParameters["time"];
          RankingTimeRange time = mapStringToRankingTimeRange(timeString);

          return RankingScreen(
            key: state.pageKey,
            type: type,
            metric: metric,
            time: time,
          );
        },
      ),
      GoRoute(
          path: '/explore',
          name: 'explore',
          builder: (BuildContext context, GoRouterState state) {
            return const ExploreScreen();
          },
          routes: [
            GoRoute(
              path: 'search',
              name: 'explore_search',
              pageBuilder: (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const SearchScreen(),
                  transitionDuration: const Duration(milliseconds: 400),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin =
                        Offset(1, 0.0); // Start from right side of the screen
                    const end = Offset.zero; // End at the center of the screen
                    final tween = Tween(begin: begin, end: end);
                    final offsetAnimation = animation
                        .drive(tween.chain(CurveTween(curve: Curves.easeIn)));

                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  }),
            ),
            GoRoute(
                path: 'result',
                name: 'explore_result',
                builder: (BuildContext context, GoRouterState state) {
                  final keyword = state.queryParameters["keyword"];
                  return ResultScreen(keyword: keyword ?? '');
                })
          ]),
      GoRoute(
          path: '/story/:storyId',
          name: 'story_detail',
          builder: (BuildContext context, GoRouterState state) {
            final storyId = state.pathParameters['storyId']!;
            print(storyId);
            // print('id' + id);
            return DetailStoryScreen(
              id: storyId,
            );
          },
          routes: [
            GoRoute(
              path: 'chapter/:chapterId',
              builder: (BuildContext context, GoRouterState state) {
                String? chapterId = state.pathParameters["chapterId"];
                return ReadingScreen(
                  chapterId: chapterId,
                );
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
        name: 'composeStory',
        path: '/composeStory',
        builder: (BuildContext context, GoRouterState state) {
          return ComposeScreen();
        },
      ),
      GoRoute(
        name: 'composeChapter',
        path: '/composeChapter/:storyTitle',
        builder: (BuildContext context, GoRouterState state) {
          final storyTitle = state.pathParameters['storyTitle']!;
          return ComposeChapterScreen(
            storyTitle: storyTitle,
          );
        },
      ),
      GoRoute(
        name: 'detailStory',
        path: '/detailStory/:storyId',
        builder: (BuildContext context, GoRouterState state) {
          print('state');
          print(state.extra);
          final storyId = state.pathParameters['storyId']!;
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
      GoRoute(
        name: 'writer',
        path: '/writer',
        builder: (BuildContext context, GoRouterState state) {
          return const WriterScreen();
        },
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
