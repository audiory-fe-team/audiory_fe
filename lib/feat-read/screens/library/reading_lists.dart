import 'package:audiory_v0/feat-read/widgets/reading_list_card.dart';
import 'package:audiory_v0/repositories/reading_list_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReadingLists extends HookWidget {
  const ReadingLists({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors? appColors = Theme.of(context).extension<AppColors>();
    final textTheme = Theme.of(context).textTheme;
    final readingListQuery = useQuery(
        ['readingList'], () => ReadingListRepository.fetchMyReadingList());

    return Expanded(
        child: Skeletonizer(
            enabled: readingListQuery.isFetching,
            child: RefreshIndicator(
                onRefresh: () async {
                  readingListQuery.refetch();
                },
                child: ListView(children: [
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Skeleton.shade(
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                    color: appColors?.skyLightest,
                                    borderRadius: BorderRadius.circular(28)),
                                child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                          Text('Tạo danh sách đọc',
                                              style: textTheme.titleMedium
                                                  ?.copyWith(
                                                      color:
                                                          appColors?.inkLight)),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Icon(Icons.add_rounded,
                                              size: 14,
                                              color: appColors?.inkBase),
                                        ])))))
                      ]),
                  const SizedBox(height: 16),
                  ...(readingListQuery.data ?? [])
                      .map((e) => Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ReadingListCard(
                            readingList: e,
                            onDeleteReadingList: (_) {},
                            onEditHandler: (_, __, ___) {},
                            onPublishHandler: (_) {},
                          )))
                      .toList(),
                ]))));
  }
}
