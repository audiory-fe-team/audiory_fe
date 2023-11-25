import 'package:audiory_v0/models/reading-list/reading_list_model.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/app_image.dart';
import 'package:flutter/material.dart';

class SeletableReadingListCard extends StatefulWidget {
  final ReadingList readingList;
  final Function(String) onSelected;
  final bool isSelected;

  const SeletableReadingListCard({
    super.key,
    required this.readingList,
    required this.onSelected,
    this.isSelected = false,
  });
  @override
  State<SeletableReadingListCard> createState() =>
      _SeletableReadingListCardState();
}

class _SeletableReadingListCardState extends State<SeletableReadingListCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final id = widget.readingList.id ?? 'not-found';
    final isPrivate = widget.readingList.isPrivate ?? true;
    final title = widget.readingList.name ?? 'Tiêu đề truyện';

    return GestureDetector(
        onTap: () {
          // GoRouter.of(context)
          //     .push("/library/reading-list/$id", extra: {'name': title});
          widget.onSelected(id);
        },
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AppImage(
                        url: widget.readingList.coverUrl,
                        width: 90,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      // Image.network(
                      //   widget.readingList.coverUrl ?? '',
                      //   color: appColors.inkLight.withOpacity(0.9),
                      //   colorBlendMode: BlendMode.modulate,
                      //   errorBuilder: (context, error, stackTrace) =>
                      //       Image.network(
                      //           'https://c0.wallpaperflare.com/preview/582/596/998/strandweg-sea-nature-romantic.jpg'),
                      // ),
                      if (widget.isSelected)
                        Container(
                            width: 90,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                            )),
                      if (widget.isSelected)
                        SizedBox(
                            child: Center(
                                child: Icon(
                          Icons.check_circle,
                          color: appColors.skyLighter,
                          weight: 20,
                          size: 40,
                        )))
                    ],
                  )),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  title,
                                  maxLines: 2,
                                  style: textTheme.titleMedium?.merge(
                                      const TextStyle(
                                          overflow: TextOverflow.ellipsis)),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                      isPrivate
                                          ? Icons.lock_rounded
                                          : Icons.public_rounded,
                                      size: 14,
                                      color: appColors.inkBase),
                                  const SizedBox(width: 2),
                                  SizedBox(
                                      width: 140,
                                      child: Text(
                                          isPrivate ? 'Riêng tư' : 'Công khai',
                                          style: textTheme.titleSmall?.copyWith(
                                              fontStyle: FontStyle.italic,
                                              overflow:
                                                  TextOverflow.ellipsis))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
