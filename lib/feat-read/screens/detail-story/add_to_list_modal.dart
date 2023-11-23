import 'dart:ffi';

import 'package:audiory_v0/feat-read/widgets/selectable_reading_list_card.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/reading_list_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddToListModal extends HookWidget {
  final String storyId;

  @override
  const AddToListModal({
    super.key,
    required this.storyId,
  });

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final selectedId = useState<String?>(null);
    final readingListQuery = useQuery(
      ['readingList'],
      () => ReadingListRepository.fetchMyReadingList(),
      refetchOnMount: RefetchOnMount.stale,
      staleDuration: const Duration(seconds: 30),
    );

    handleAddToReadingList() async {
      if (selectedId.value == null) return;
      try {
        await ReadingListRepository.addStoryToReadingList(
            selectedId.value, storyId);

        Navigator.of(context).pop();
      } catch (e) {
        AppSnackBar.buildTopSnackBar(
            context, "Thêm lỗi", null, SnackBarType.error);
      }
      // listStoriesQuery.refetch();
      await AppSnackBar.buildTopSnackBar(
          context, "Thêm thành công", null, SnackBarType.success);
    }

    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        builder: (context, scrollController) => Scaffold(
              body: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: appColors.skyBase,
                            width: 0.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: IconButton(
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -4),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon:
                                    const Icon(Icons.close_outlined, size: 18)),
                          ),
                          Flexible(
                              flex: 7,
                              child: GestureDetector(
                                onTap: () {
                                  context.pop();
                                },
                                child: Text(
                                  'Chọn danh sách để thêm ',
                                  textAlign: TextAlign.center,
                                  style: textTheme.headlineSmall
                                      ?.copyWith(color: appColors.inkDarkest),
                                ),
                              )),
                          Flexible(
                              flex: 2,
                              child: FilledButton(
                                  onPressed: () {
                                    if (selectedId.value != null) {
                                      handleAddToReadingList();
                                    }
                                  },
                                  style: FilledButton.styleFrom(
                                      visualDensity: const VisualDensity(
                                          horizontal: -2, vertical: -2),
                                      padding: EdgeInsets.zero,
                                      backgroundColor: selectedId.value == null
                                          ? appColors.skyBase
                                          : appColors.primaryBase),
                                  child: Text(
                                    'Thêm',
                                    textAlign: TextAlign.center,
                                    style: textTheme.titleMedium
                                        ?.copyWith(color: Colors.white),
                                  ))),
                        ],
                      )),
                  Expanded(
                      child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    children: List.generate(
                      readingListQuery.data != null
                          ? readingListQuery.data?.length as int
                          : 0,
                      (index) {
                        if (readingListQuery.data == null) {
                          return const SizedBox();
                        }
                        final readingList = readingListQuery.data![index];

                        return Skeletonizer(
                          enabled: readingListQuery.isFetching,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SeletableReadingListCard(
                                readingList: readingList,
                                isSelected: selectedId.value == readingList.id,
                                onSelected: (listId) {
                                  if (selectedId.value == listId) {
                                    selectedId.value = null;
                                  } else {
                                    selectedId.value = listId;
                                  }
                                }),
                          ),
                        );
                      },
                    ).toList(),
                  ))
                ],
              ),
            ));
  }
}
