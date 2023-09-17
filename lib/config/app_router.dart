import 'package:audiory_v0/feat-explore/screens/category_screen.dart';
import 'package:audiory_v0/feat-explore/screens/home_screen.dart';
import 'package:audiory_v0/feat-explore/utils/ranking.dart';
import 'package:audiory_v0/feat-explore/models/ranking.dart';
import 'package:audiory_v0/feat-explore/screens/explore_screen.dart';
import 'package:audiory_v0/feat-explore/screens/ranking_screen.dart';
import 'package:audiory_v0/feat-explore/screens/search_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/user_profile_screen.dart';
import 'package:audiory_v0/feat-read/screens/reading_screen.dart';
import 'package:audiory_v0/feat-write/screens/layout/compose_chapter_screen.dart';
import 'package:audiory_v0/feat-write/screens/layout/compose_screen.dart';
import 'package:audiory_v0/feat-write/screens/layout/preview_chapter_screen.dart';
import 'package:audiory_v0/feat-write/screens/writer_screen.dart';
import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/layout/not_found_screen.dart';
import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/screens/register/register_screen.dart';
import 'package:audiory_v0/screens/register/screens/flow_four.dart';
import 'package:audiory_v0/screens/register/screens/flow_one.dart';
import 'package:audiory_v0/screens/register/screens/flow_three.dart';
import 'package:audiory_v0/screens/register/screens/flow_two.dart';

import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/screens/login/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//auth
import "package:firebase_auth/firebase_auth.dart";

import '../feat-read/screens/detail_story_screen.dart';

class AppRoutes {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter routes = GoRouter(
    navigatorKey: _rootNavigatorKey,
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
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return Scaffold(
              body: child,
              bottomNavigationBar: const AppBottomNavigationBar(),
            );
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
                return const HomeScreen();
              },
            ),
            GoRoute(
              path: '/ranking',
              name: 'ranking',
              builder: (BuildContext context, GoRouterState state) {
                final typeString = state.queryParameters["type"];
                RankingType type = mapStringToRankingType(typeString);
                final metricString = state.queryParameters["metric"];
                RankingMetric metric = mapStringToRankingMetric(metricString);
                final timeString = state.queryParameters["time"];
                RankingTimeRange time = mapStringToRankingTimeRange(timeString);
                final category = state.queryParameters["category"];
                return RankingScreen(
                  key: state.pageKey,
                  type: type,
                  metric: metric,
                  time: time,
                  category: category,
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
                          const begin = Offset(
                              1, 0.0); // Start from right side of the screen
                          const end =
                              Offset.zero; // End at the center of the screen
                          final tween = Tween(begin: begin, end: end);
                          final offsetAnimation = animation.drive(
                              tween.chain(CurveTween(curve: Curves.easeIn)));

                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        }),
                  ),
                  GoRoute(
                    name: 'explore_category',
                    path: 'category/:categoryName',
                    builder: (_, GoRouterState state) {
                      final categoryName = state.pathParameters["categoryName"];
                      if (categoryName != null && categoryName != "") {
                        return CategoryScreen(categoryName: categoryName);
                      }
                      return const NotFoundScreen();
                    },
                  ),
                ]),
            GoRoute(
              name: 'profile',
              path: '/profile',
              builder: (_, GoRouterState state) {
                return const UserProfileScreen();
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
          ]),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/story/:storyId',
          name: 'story_detail',
          builder: (BuildContext context, GoRouterState state) {
            final storyId = state.pathParameters['storyId'];
            return DetailStoryScreen(
              id: storyId ?? '',
            );
          },
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: 'chapter/:chapterId',
              name: 'chapter_detail',
              builder: (BuildContext context, GoRouterState state) {
                String? chapterId = state.pathParameters["chapterId"];
                if (chapterId == null || chapterId == '') {
                  return const NotFoundScreen();
                }
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
        name: 'flowOne',
        path: '/flowOne',
        builder: (BuildContext context, GoRouterState state) {
          return const FlowOneScreen();
        },
      ),
      GoRoute(
        name: 'flowTwo',
        path: '/flowTwo',
        builder: (BuildContext context, GoRouterState state) {
          final extraMap = state.extra as Map<String, dynamic>;
          if (kDebugMode) {
            print(extraMap['signUpBody'] == '' ? 'empty' : 'no');
          }
          final body = extraMap['signUpBody'] as Map<String, String>;
          return FlowTwoScreen(signUpBody: body);
        },
      ),
      GoRoute(
        name: 'flowThree',
        path: '/flowThree',
        builder: (BuildContext context, GoRouterState state) {
          return const FlowThreeScreen();
        },
      ),
      GoRoute(
        name: 'flowFour',
        path: '/flowFour',
        builder: (BuildContext context, GoRouterState state) {
          return const FLowFourScreen();
        },
      ),
      GoRoute(
        name: 'composeStory',
        path: '/composeStory',
        builder: (BuildContext context, GoRouterState state) {
          //extra
          final extraMap = state.extra as Map<String, dynamic>;
          if (kDebugMode) {
            print('storyId');
            print(extraMap['storyId'] == '' ? 'empty' : 'no');
          }
          final storyId = extraMap['storyId'] as String?;
          return ComposeScreen(
              //extra
              storyId: storyId);
        },
      ),
      GoRoute(
        name: 'previewChapter',
        path: '/previewChapter',
        builder: (BuildContext context, GoRouterState state) {
          //extra

          final extraMap = state.extra as Map<String, dynamic>;
          print('extra map ${extraMap}');
          final chapterId = extraMap['chapterId'] == ''
              ? null
              : extraMap['chapterId'] as String?;
          final storyId =
              extraMap['storyId'] == '' ? null : extraMap['storyId'] as String?;
          return PreviewChapterScreen(
            //extra
            storyId: storyId,
            chapterId: chapterId,
          );
        },
      ),
      GoRoute(
        name: 'composeChapter',
        path: '/composeChapter',
        builder: (BuildContext context, GoRouterState state) {
          //extra

          final extraMap = state.extra as Map<String, dynamic>;
          print('extra map ${extraMap}');
          final story =
              extraMap['story'] == '' ? null : extraMap['story'] as Story?;
          final chapterId = extraMap['chapterId']! as String?;
          return ComposeChapterScreen(
              //extra
              story: story,
              chapterId: chapterId);
        },
      ),
    ],
  );

  static String? _redirect(BuildContext context, GoRouterState state) {
    final User? user = AuthRepository().currentUser;
    // return user != null ? null : context.namedLocation('/login');
    return user != null
        ? null
        : Uri(
            path: '/login',
            queryParameters: {'redirect_to': state.location},
          ).toString();
  }
}
