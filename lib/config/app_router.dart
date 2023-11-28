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
import 'package:audiory_v0/feat-manage-profile/screens/privacy-lists/block_accounts_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/privacy-lists/mute_accounts_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/privacy-lists/reports_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/profile_settings_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/user_profile_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/wallet/new_purchase_screen.dart';
import 'package:audiory_v0/feat-manage-profile/screens/wallet/wallet_screen.dart';
import 'package:audiory_v0/feat-read/screens/library/library_screen.dart';
import 'package:audiory_v0/feat-read/screens/reading-list/reading_list_screen.dart';
import 'package:audiory_v0/feat-read/screens/reading/audio_bottom_bar.dart';
import 'package:audiory_v0/feat-read/screens/reading/reading_screen.dart';
import 'package:audiory_v0/feat-write/screens/layout/compose_chapter_screen.dart';
import 'package:audiory_v0/feat-write/screens/layout/compose_screen.dart';
import 'package:audiory_v0/feat-write/screens/paywalled_screen.dart';
import 'package:audiory_v0/feat-write/screens/writer_screen.dart';
import 'package:audiory_v0/feat-write/screens/writer_story_overview_screen.dart';
import 'package:audiory_v0/layout/bottom_bar.dart';
import 'package:audiory_v0/layout/not_found_screen.dart';
import 'package:audiory_v0/models/AuthUser.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/feat-auth/screens/register/register_screen.dart';
import 'package:audiory_v0/feat-auth/screens/register/screens/flow_four.dart';
import 'package:audiory_v0/feat-auth/screens/register/screens/flow_two.dart';
import 'package:audiory_v0/feat-auth/screens/register/screens/flow_three.dart';
import 'package:audiory_v0/feat-auth/screens/register/screens/flow_one.dart';

import 'package:audiory_v0/feat-auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

//auth

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
              floatingActionButton: const AudioBottomBar(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniCenterFloat,
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
                      redirect: _redirect,
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
                    parentNavigatorKey: _rootNavigatorKey,
                    name: 'accountProfile',
                    path: 'accountProfile/:id',
                    builder: (BuildContext context, GoRouterState state) {
                      final id = state.pathParameters['id'];

                      if (id == null || id == '' || id == 'not-found') {
                        return const NotFoundScreen();
                      }
                      // return UserProfileScreen();
                      return AppProfileScreen(
                        id: id,
                      );
                    },
                  ),
                  GoRoute(
                      redirect: _redirect,
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
                    redirect: _redirect,
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
            var hasDownload = false;
            if (state.extra != null) {
              final extraMap = state.extra as Map<dynamic, dynamic>;
              hasDownload = extraMap['hasDownload'] ?? true;
            }

            print(hasDownload);

            if (storyId == null || storyId == '' || storyId == 'not-found') {
              return const NotFoundScreen();
            }
            return DetailStoryScreen(
              hasDownload: hasDownload,
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
                print(tagName);
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
                String? storyId = state.pathParameters["storyId"];

                final offsetString = state.queryParameters["offset"];

                if (chapterId == null ||
                    chapterId == '' ||
                    storyId == null ||
                    storyId == '') {
                  return const NotFoundScreen();
                }
                return ReadingScreen(
                  chapterId: chapterId,
                  storyId: storyId,
                  initialOffset:
                      offsetString == null ? null : int.parse(offsetString),
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
            ),
          ]),
      GoRoute(
          name: 'muteAccounts',
          path: '/muteAccounts',
          builder: (BuildContext context, GoRouterState state) {
            final extraMap = state.extra as Map<String, dynamic>;
            final userId = extraMap['userId'] ?? null;
            return MuteAccountsScreen(userId: userId);
          }),
      GoRoute(
          name: 'reports',
          path: '/reports',
          builder: (BuildContext context, GoRouterState state) {
            final extraMap = state.extra as Map<String, dynamic>;
            final userId = extraMap['userId'] ?? null;
            return ReportsScreen(userId: userId);
          }),
      GoRoute(
          name: 'newReport',
          path: '/newReport',
          builder: (BuildContext context, GoRouterState state) {
            final extraMap = state.extra as Map<String, dynamic>;
            final userId = extraMap['userId'] ?? null;
            return ReportsScreen(userId: userId);
          }),
      GoRoute(
          name: 'blockAccounts',
          path: '/blockAccounts',
          builder: (BuildContext context, GoRouterState state) {
            final extraMap = state.extra as Map<String, dynamic>;
            final userId = extraMap['userId'] ?? null;
            return BlockAccountsScreen(userId: userId);
          }),
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
        parentNavigatorKey: _rootNavigatorKey,
        name: 'editStoryOverview',
        path: '/editStoryOverview',
        builder: (BuildContext context, GoRouterState state) {
          //extra
          final extraMap = state.extra as Map<String, dynamic>;
          print(extraMap);
          final storyId = extraMap['storyId'] ?? '';
          return WriterStoryOverviewScreen(
              //extra
              storyId: storyId);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: 'paywallStory',
        path: '/paywallStory',
        builder: (BuildContext context, GoRouterState state) {
          //extra
          final extraMap = state.extra as Map<String, dynamic>;
          final story = extraMap['story'] ?? '';
          return PaywalledScreen(
              //extra
              story: story);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: 'composeStory',
        path: '/composeStory',
        builder: (BuildContext context, GoRouterState state) {
          //extra
          final extraMap = state.extra as Map<String, dynamic>;
          final storyId = extraMap['storyId'] ?? '';
          return ComposeScreen(
              //extra
              storyId: storyId);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: 'composeChapter',
        path: '/composeChapter',
        builder: (BuildContext context, GoRouterState state) {
          //extra

          final extraMap = state.extra as Map<String, dynamic>;
          final story =
              extraMap['story'] == '' ? null : extraMap['story'] as Story?;
          final chapterId = (extraMap['chapterId'] ?? '');
          final chapter = (extraMap['chapter']);
          return ComposeChapterScreen(
            //extra
            story: story,
            chapterId: chapterId,
            chapter: chapter,
          );
        },
      ),
    ],
  );

  static Future<String?> _redirect(
      BuildContext context, GoRouterState state) async {
    const storage = FlutterSecureStorage();
    final jwtToken = await storage.read(key: 'jwt');

    return jwtToken != null
        ? null
        : Uri(
            path: '/login',
            queryParameters: {'redirect_to': state.location},
          ).toString();
  }
}
