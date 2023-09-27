import 'dart:convert';

import 'package:audiory_v0/feat-manage-library/screens/mock_list.dart';
import 'package:audiory_v0/feat-manage-library/widgets/reading_scroll_lists.dart';
import 'package:audiory_v0/feat-manage-profile/data/repositories/profile_repository.dart';
import 'package:audiory_v0/models/ReadingList.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fquery/fquery.dart';

import '../../models/AuthUser.dart';
import '../../theme/theme_constants.dart';

class LibraryScreen extends StatefulHookWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final storage = const FlutterSecureStorage();
  UserServer? currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    Future<UserServer?> getUserDetails() async {
      String? value = await storage.read(key: 'currentUser');
      currentUser =
          value != null ? UserServer.fromJson(jsonDecode(value)['data']) : null;

      return currentUser;
    }

    Future<List<ReadingList>>? getReadingList() async {
      currentUser = await getUserDetails();
      print('IS ${currentUser?.id}');
      List<ReadingList>? lists = await StoryRepostitory()
          .fetchReadingStoriesByUserId('66b8f778-5506-11ee-8fba-0242ac180002');
      return lists as List<ReadingList>;
    }

    // final readingStoriesQuery = useQuery(
    //     ['readingList'],
    //     () => StoryRepostitory().fetchReadingStoriesByUserId(
    //         '66b8f778-5506-11ee-8fba-0242ac180002'));
    return Scaffold(
      appBar: CustomAppBar(
          title: Text('Thư viện',
              style: textTheme.headlineMedium
                  ?.copyWith(color: appColors.inkDarkest)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            )
          ]),
      body: FutureBuilder<List<ReadingList>>(
        future: getReadingList(), // async work
        builder:
            (BuildContext context, AsyncSnapshot<List<ReadingList>?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return const Scaffold(
                  body: Center(
                      child: Column(
                    children: [
                      // Text('can dang nhap'),

                      ReadingScrollList(
                        storyList: LISTS,
                        length: 2,
                      )
                    ],
                  )),
                );
              } else {
                return Center(child: Text('${snapshot.data?.length}'));
              }
          }
        },
      ),
    );
  }
}
