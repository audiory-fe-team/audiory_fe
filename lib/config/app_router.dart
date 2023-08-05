import 'package:audiory_v0/feat-explore/screens/explore_screen.dart';
import 'package:audiory_v0/feat-explore/screens/result_screen.dart';
import 'package:audiory_v0/feat-explore/screens/search_screen.dart';
import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/feat-explore/screens/home_screen.dart';
import 'package:audiory_v0/screens/reading/reading_screen.dart';
import 'package:audiory_v0/services/auth_services.dart';
import 'package:audiory_v0/screens/home_test/profile_screen_test.dart';
import 'package:audiory_v0/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//auth
import "package:firebase_auth/firebase_auth.dart";
import 'package:page_transition/page_transition.dart';

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
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreeen();
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
                  child: SearchScreen(),
                  transitionDuration: Duration(milliseconds: 400),
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
          builder: (BuildContext context, GoRouterState state) {
            return const ExploreScreen();
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
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (_, GoRouterState state) {
          return const ProfileScreenTest();
        },
        redirect: _redirect,
      )
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
