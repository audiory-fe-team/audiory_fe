import 'package:audiory_v0/models/story/story_model.dart';
import 'package:flutter/material.dart';

import '../../theme/theme_constants.dart';

class RandomStoryCard extends StatefulWidget {
  final Story story;
  final VoidCallback onStorySelected;
  const RandomStoryCard(
      {super.key, required this.story, required this.onStorySelected});

  @override
  State<RandomStoryCard> createState() => RandomStoryCardState();
}

class RandomStoryCardState extends State<RandomStoryCard> {
  bool isSelected = false;

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      // decoration: new BoxDecoration(
      //   borderRadius: new BorderRadius.circular(16.0),
      //   color: Colors.green,
      // ),
      width: size.width / 4,
      height: size.height / 3.5,
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              child: InkWell(
                hoverColor: appColors.inkBase,
                onTap: () async {
                  setState(() {
                    widget.onStorySelected();
                    isSelected = !isSelected;
                  });
                },
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: isSelected
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(
                              widget.story.coverUrl as String,
                              color: appColors.inkLight.withOpacity(0.9),
                              colorBlendMode: BlendMode.modulate,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.network(
                                      'https://c0.wallpaperflare.com/preview/582/596/998/strandweg-sea-nature-romantic.jpg'),
                            ),
                            SizedBox(
                                child: Center(
                                    child: Icon(
                              Icons.check_circle,
                              color: appColors.skyLighter,
                              weight: 20,
                              size: 40,
                            )))
                          ],
                        )
                      : Image.network(
                          widget.story.coverUrl as String,
                        ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            Center(
              child: Text(
                widget.story.title,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: appColors.inkBase),
                maxLines: 2,
              ),
            )
          ]),
    );
  }
}
