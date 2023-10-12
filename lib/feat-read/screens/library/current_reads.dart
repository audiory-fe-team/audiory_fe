import 'package:audiory_v0/feat-read/widgets/current_read_card.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/library_repository.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CurrentReadings extends HookWidget {
  const CurrentReadings({super.key});

  @override
  Widget build(BuildContext context) {
    final libraryQuery =
        useQuery(['library'], () => LibraryRepository.fetchMyLibrary());

    handleDeleteStory(String id) async {
      try {
        await LibraryRepository.deleteStoryFromMyLibrary(id);
      } catch (error) {
        AppSnackBar.buildTopSnackBar(
            context, 'Xóa thất bại, thử lại sau.', null, SnackBarType.error);
      }
      libraryQuery.refetch();
      // ignore: use_build_context_synchronously
      await AppSnackBar.buildTopSnackBar(
          context, 'Xóa thành công.', null, SnackBarType.success);
    }

    return Expanded(
        child: Skeletonizer(
            enabled: libraryQuery.isFetching,
            child: RefreshIndicator(
                onRefresh: () async {
                  libraryQuery.refetch();
                },
                child: ListView(
                    children: (libraryQuery.data?.libraryStory ?? [])
                        .map((e) => Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: CurrentReadCard(
                              libStory: e,
                              onDeleteStory: (id) => handleDeleteStory(id),
                            )))
                        .toList()))));
  }
}
