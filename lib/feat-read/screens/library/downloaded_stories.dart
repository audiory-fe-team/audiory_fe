import 'package:audiory_v0/constants/skeletons.dart';
import 'package:audiory_v0/feat-read/widgets/current_read_card.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/providers/story_database.dart';
import 'package:audiory_v0/repositories/library_repository.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DownloadedStories extends StatefulWidget {
  const DownloadedStories({Key? key}) : super(key: key);

  @override
  _DownloadedStoriesState createState() => _DownloadedStoriesState();
}

class _DownloadedStoriesState extends State<DownloadedStories> {
  late Future<List<Story>?> libraryData;
  final storyDb = StoryDatabase();

  @override
  void initState() {
    super.initState();
    libraryData = storyDb.getAllStories();
  }

  Future<void> handleDeleteStory(String id) async {
    try {
      await LibraryRepository.deleteStoryFromMyLibrary(id);
    } catch (error) {
      AppSnackBar.buildTopSnackBar(
          context, 'Xóa thất bại, thử lại sau.', null, SnackBarType.error);
    }
    setState(() {
      libraryData = storyDb.getAllStories();
    });
    await AppSnackBar.buildTopSnackBar(
        context, 'Xóa thành công.', null, SnackBarType.success);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Story>?>(
        future: libraryData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Skeletonizer(
              enabled: true, // Enable skeleton loading
              child: ListView(
                  children: skeletonStories.map((e) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: CurrentReadCard(
                    story: e,
                    onDeleteStory: (id) => handleDeleteStory(id),
                  ),
                );
              }).toList()),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Bạn chưa tải truyện nào.'));
          } else {
            final libraryStoryList = snapshot.data!;
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  libraryData = storyDb.getAllStories();
                });
              },
              child: ListView(
                children: libraryStoryList.map((e) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: CurrentReadCard(
                      story: e,
                      onDeleteStory: (id) => handleDeleteStory(id),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
