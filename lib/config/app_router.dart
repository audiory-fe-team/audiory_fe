import 'package:audiory_v0/feat-auth/screens/forgot_password/forgot_password_screen.dart';
import 'package:audiory_v0/feat-auth/screens/forgot_password/reset_password_screen.dart';
import 'package:audiory_v0/feat-explore/screens/category_screen.dart';
import 'package:audiory_v0/feat-explore/screens/home_screen.dart';
import 'package:audiory_v0/feat-explore/screens/notification_screen.dart';
import 'package:audiory_v0/feat-explore/screens/profile_screen.dart';
import 'package:audiory_v0/feat-explore/screens/tag_screen.dart';
import 'package:audiory_v0/feat-explore/utils/ranking.dart';
import 'package:audiory_v0/feat-explore/models/ranking.dart';
import 'package:audiory_v0/feat-explore/screens/explore_screen.dart';
import 'package:audiory_v0/feat-explore/screens/ranking_screen.dart';
import 'package:audiory_v0/feat-explore/screens/search_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/daily-rewards/daily_rewards_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/edit_account_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/edit_profile_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/edit_email_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/messages/detail_conversation_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/messages/messages_list_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/profile_settings_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/user_profile_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/wallet/new_purchase_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/wallet/wallet_screen.dart';
import 'package:audiory_v0/feat-read/screens/library/library_screen.dart';
import 'package:audiory_v0/feat-read/screens/reading-list/reading_list_screen.dart';
import 'package:audiory_v0/feat-read/screens/reading/reading_screen.dart';
import 'package:audiory_v0/feat-write/screens/layout/compose_chapter_screen.dart';
import 'package:audiory_v0/feat-write/screens/layout/compose_screen.dart';
import 'package:audiory_v0/feat-write/screens/layout/preview_chapter_screen.dart';
import 'package:audiory_v0/feat-write/screens/writer_screen.dart';
import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/layout/not_found_screen.dart';
import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/models/author-story/author_story_model.dart';
import 'package:audiory_v0/models/conversation/conversation_model.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/feat-auth/screens/register/register_screen.dart';
import 'package:audiory_v0/feat-auth/screens/register/screens/flow_four.dart';
import 'package:audiory_v0/feat-auth/screens/register/screens/flow_two.dart';
import 'package:audiory_v0/feat-auth/screens/register/screens/flow_three.dart';
import 'package:audiory_v0/feat-auth/screens/register/screens/flow_one.dart';

import 'package:audiory_v0/repositories/auth_repository.dart';
import 'package:audiory_v0/feat-auth/screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//auth
import "package:firebase_auth/firebase_auth.dart";

import '../feat-read/screens/detail-story/detail_story_screen.dart';
import '../models/Profile.dart';

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
                routes: [
                  GoRoute(
                      parentNavigatorKey: _shellNavigatorKey,
                      name: 'library',
                      path: 'library',
                      builder: (_, GoRouterState state) {
                        return const LibraryScreen();
                      },
                      routes: [
                        GoRoute(
                          name: 'reading_list',
                          path: 'reading-list/:id',
                          builder: (_, GoRouterState state) {
                            final id = state.pathParameters['id'];
                            final extraMap =
                                state.extra as Map<String, dynamic>;
                            final name = extraMap['name'] as String;

                            if (id == null || id == '' || id == 'not-found') {
                              return const NotFoundScreen();
                            }
                            return ReadingListScreen(
                              id: id,
                              name: name,
                            );
                          },
                        )
                      ]),
                  GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    path: 'ranking',
                    name: 'ranking',
                    builder: (BuildContext context, GoRouterState state) {
                      final typeString = state.queryParameters["type"];
                      RankingType type = mapStringToRankingType(typeString);
                      final metricString = state.queryParameters["metric"];
                      RankingMetric metric =
                          mapStringToRankingMetric(metricString);
                      final timeString = state.queryParameters["time"];
                      RankingTimeRange time =
                          mapStringToRankingTimeRange(timeString);
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
                      parentNavigatorKey: _shellNavigatorKey,
                      path: 'explore',
                      name: 'explore',
                      builder: (BuildContext context, GoRouterState state) {
                        return const ExploreScreen();
                      },
                      routes: [
                        GoRoute(
                          path: 'search',
                          name: 'explore_search',
                          pageBuilder: (context, state) =>
                              CustomTransitionPage<void>(
                                  key: state.pageKey,
                                  child: const SearchScreen(),
                                  transitionDuration:
                                      const Duration(milliseconds: 400),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(1,
                                        0.0); // Start from right side of the screen
                                    const end = Offset
                                        .zero; // End at the center of the screen
                                    final tween = Tween(begin: begin, end: end);
                                    final offsetAnimation = animation.drive(
                                        tween.chain(
                                            CurveTween(curve: Curves.easeIn)));

                                    return SlideTransition(
                                        position: offsetAnimation,
                                        child: child);
                                  }),
                        ),
                        GoRoute(
                          name: 'explore_category',
                          path: 'category/:categoryName',
                          builder: (_, GoRouterState state) {
                            final categoryName =
                                state.pathParameters["categoryName"];

                            if (categoryName != null && categoryName != "") {
                              return CategoryScreen(categoryName: categoryName);
                            }
                            return const NotFoundScreen();
                          },
                        ),
                      ]),
                  GoRoute(
                      parentNavigatorKey: _shellNavigatorKey,
                      name: 'profile',
                      path: 'profile',
                      builder: (_, GoRouterState state) {
                        return const UserProfileScreen();
                      },
                      routes: [
                        GoRoute(
                          parentNavigatorKey: _shellNavigatorKey,
                          name: 'dailyReward',
                          path: 'dailyReward',
                          builder: (_, GoRouterState state) {
                            return const DailyRewardsScreen();
                          },
                        ),
                      ]),
                  GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    name: 'writer',
                    path: 'writer',
                    builder: (BuildContext context, GoRouterState state) {
                      return const WriterScreen();
                    },
                  ),
                  GoRoute(
                    parentNavigatorKey: _shellNavigatorKey,
                    path: 'notification',
                    name: 'notification',
                    builder: (BuildContext context, GoRouterState state) {
                      return const NotificationScreen();
                    },
                  ),
                ]),
          ]),
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: '/story/:storyId',
          name: 'story_detail',
          builder: (BuildContext context, GoRouterState state) {
            final storyId = state.pathParameters['storyId'];
            if (storyId == null || storyId == '' || storyId == 'not-found') {
              return const NotFoundScreen();
            }
            return DetailStoryScreen(
              id: storyId,
            );
          },
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              name: 'tag',
              path: 'tag/:tagId',
              builder: (_, GoRouterState state) {
                final tagId = state.pathParameters["tagId"];
                final tagName = state.queryParameters["tagName"];
                if (tagId != null && tagName != null) {
                  return SearchTagScreen(tagId: tagId, tagName: tagName);
                }
                return const NotFoundScreen();
              },
            ),
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
        parentNavigatorKey: _rootNavigatorKey,
        name: 'login',
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: 'forgotPassword',
        path: '/forgotPassword',
        builder: (BuildContext context, GoRouterState state) {
          return const ForgotPasswordScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: 'resetPassword',
        path: '/resetPassword',
        builder: (BuildContext context, GoRouterState state) {
          final extraMap = state.extra as Map<String, dynamic>;
          final token = extraMap['resetToken'] ?? {'': ''};
          return ResetPasswordScreen(resetToken: token);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
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
          final extraMap = state.extra as Map<String, dynamic>;
          final body = extraMap['signUpBody'] ?? {'': ''};
          return FlowOneScreen(signUpBody: body);
        },
      ),
      GoRoute(
        name: 'flowTwo',
        path: '/flowTwo',
        builder: (BuildContext context, GoRouterState state) {
          final extraMap = state.extra as Map<String, dynamic>;
          final userId = extraMap['userId'] as String;
          return FlowTwoScreen(userId: userId);
        },
      ),
      GoRoute(
        name: 'flowThree',
        path: '/flowThree',
        builder: (BuildContext context, GoRouterState state) {
          final extraMap = state.extra as Map<String, dynamic>;
          final userId = extraMap['userId'] as String;
          return FlowThreeScreen(userId: userId);
        },
      ),
      GoRoute(
        name: 'flowFour',
        path: '/flowFour',
        builder: (BuildContext context, GoRouterState state) {
          final extraMap = state.extra as Map<String, dynamic>;
          final userId = extraMap['userId'] as String;
          return FLowFourScreen(userId: userId);
        },
      ),
      GoRoute(
          name: 'profileSettings',
          path: '/profileSettings',
          builder: (BuildContext context, GoRouterState state) {
            final extraMap = state.extra as Map<String, dynamic>;
            final currentUser = extraMap["currentUser"] as AuthUser;
            final userProfile = extraMap["userProfile"] as Profile;
            return ProfileSettingsScreen(
                currentUser: currentUser, userProfile: userProfile);
          },
          routes: [
            GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                name: 'messages',
                path: 'messages',
                builder: (BuildContext context, GoRouterState state) {
                  final extraMap = state.extra as Map<String, dynamic>;
                  final userId = extraMap['userId'] as String;
                  return MessagesListScreen(userId: userId);
                },
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    name: 'detailMessage',
                    path: 'detailMessage',
                    builder: (BuildContext context, GoRouterState state) {
                      final extraMap = state.extra as Map<String, dynamic>;
                      final conversation = extraMap['conversation'] ?? null;
                      final userId = extraMap['userId'] ?? null;
                      return DetailConversationScreen(
                          conversation: conversation, userId: userId);
                    },
                  ),
                ]),
          ]),
      GoRoute(
        name: 'wallet',
        path: '/wallet',
        builder: (BuildContext context, GoRouterState state) {
          final extraMap = state.extra as Map<String, dynamic>;
          final currentUser = extraMap["currentUser"] as AuthUser;
          return WalletScreen(currentUser: currentUser);
        },
        routes: [
          GoRoute(
            name: 'newPurchase',
            path: 'newPurchase',
            builder: (BuildContext context, GoRouterState state) {
              final extraMap = state.extra as Map<String, dynamic>;
              final currentUser = extraMap["currentUser"] as AuthUser;
              return NewPurchaseScreen(
                currentUser: currentUser,
              );
            },
          )
        ],
      ),
      GoRoute(
          name: 'editProfile',
          path: '/editProfile',
          builder: (BuildContext context, GoRouterState state) {
            final extraMap = state.extra as Map<String, dynamic>;

            final currentUser = extraMap["currentUser"] as AuthUser;
            final userProfile = extraMap["userProfile"] as Profile;

            return EditProfileScreen(
                currentUser: currentUser, userProfile: userProfile);
          }),
      GoRoute(
        name: 'editAccount',
        path: '/editAccount',
        builder: (BuildContext context, GoRouterState state) {
          final extraMap = state.extra as Map<String, dynamic>;

          final currentUser = extraMap["currentUser"] as AuthUser;
          final userProfile = extraMap["userProfile"] as Profile;

          return EditAccountScreen(
              currentUser: currentUser, userProfile: userProfile);
        },
        routes: [
          GoRoute(
            path: 'editEmail',
            name: 'editEmail',
            builder: (BuildContext context, GoRouterState state) {
              final extraMap = state.extra as Map<String, dynamic>;

              final currentUser = extraMap["currentUser"] as AuthUser;
              final userProfile = extraMap["userProfile"] as Profile;

              return EditEmailScreen(
                currentUser: currentUser,
              );
            },
          )
        ],
      ),
      GoRoute(
        name: 'composeStory',
        path: '/composeStory',
        builder: (BuildContext context, GoRouterState state) {
          //extra
          final extraMap = state.extra as Map<String, dynamic>;
          if (kDebugMode) {
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
          print('extra map $extraMap');
          final story =
              extraMap['story'] == '' ? null : extraMap['story'] as Story?;
          final chapterId = extraMap['chapterId']! as String?;
          return ComposeChapterScreen(
              //extra
              story: story,
              chapterId: chapterId);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: 'accountProfile',
        path: '/accountProfile/:id',
        builder: (BuildContext context, GoRouterState state) {
          final id = state.pathParameters['id'];
          print('ID $id');
          final extraMap = state.extra as Map<String, dynamic>;
          final name = extraMap['name'] ?? '';
          final avatar = extraMap['avatar'] ?? '';
          print('alo');
          if (id == null || id == '' || id == 'not-found') {
            return const NotFoundScreen();
          }
          return AppProfileScreen(
            name: name,
            avatar: avatar,
            id: id,
          );
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
