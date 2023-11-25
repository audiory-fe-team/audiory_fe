import 'package:audiory_v0/models/story/story_model.dart';
import 'package:audiory_v0/repositories/feedbacks_repository.dart';
import 'package:audiory_v0/repositories/story_repository.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/cards/random_story_card.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../models/enums/SnackbarType.dart';
import '../../../../theme/theme_constants.dart';

class FlowThreeScreen extends StatefulHookWidget {
  final String userId;
  const FlowThreeScreen({super.key, required this.userId});

  @override
  State<FlowThreeScreen> createState() => _FlowThreeScreenState();
}

class _FlowThreeScreenState extends State<FlowThreeScreen>
    with SingleTickerProviderStateMixin {
  // this variable determnines whether the back-to-top button is shown or not
  bool _showBackToTopButton = false;

  // scroll controller
  late ScrollController _scrollController;

  late AnimationController _animationController;
  List<String> selectedStoriesList = [];

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
    _animationController = AnimationController(
        vsync: this,
        duration:
            const Duration(seconds: 1)) //with SingleTickerProviderStateMixin
      ..addListener(() {
        setState(() {});
      })
      ..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0,
          duration: const Duration(seconds: 1), curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final storiesQuery = useQuery(
        ['topStories'], () => StoryRepostitory().fetchTopStoriesForNewUser());
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              //scrollcontroller
              controller: _scrollController,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Có thể bạn yêu thích",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: appColors.inkDarkest)),
                      Text("Chọn ít nhất 5 truyện để tối ưu hóa gợi ý cho bạn",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: appColors.inkDarkest,
                                  fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width,
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              alignment: WrapAlignment.spaceBetween,
                              children: List.generate(
                                storiesQuery.data != null
                                    ? storiesQuery.data?.length as int
                                    : 0,
                                (index) {
                                  return Skeletonizer(
                                    enabled: storiesQuery.isFetching,
                                    child: RandomStoryCard(
                                      story: storiesQuery.data?[index] as Story,
                                      onStorySelected: () {
                                        setState(() {
                                          String storyId = storiesQuery
                                              .data?[index].id as String;
                                          if (selectedStoriesList
                                              .contains(storyId)) {
                                            selectedStoriesList.remove(storyId);
                                          } else {
                                            selectedStoriesList.add(storyId);
                                          }
                                        });
                                      },
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width - 32,
                      child: AppIconButton(
                        title: "Tiếp tục",
                        color: Colors.white,
                        bgColor: const Color(0xFF439A97),
                        onPressed: () async {
                          print('USERID FLOW 3 ${widget.userId}');
                          if (selectedStoriesList.length < 5) {
                            AppSnackBar.buildCustomTopSnackbar(
                                context,
                                'Chọn ít nhất 5 truyện',
                                null,
                                SnackBarType.warning,
                                300);
                          } else {
                            Map<String, String?> body = {};

                            body['user_id'] = widget.userId;
                            body['story_id'] = selectedStoriesList[0];
                            body['event_type'] = 'VIEW';
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                });
                            for (var ele in selectedStoriesList) {
                              body['story_id'] = ele;
                              await FeedbackRepository().createFeedback(body);
                            }
                            // ignore: use_build_context_synchronously
                            context.push('/flowFour',
                                extra: {'userId': widget.userId});
                          }
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: _showBackToTopButton
              ? Container(
                  margin: const EdgeInsets.only(bottom: 60),
                  child: FloatingActionButton(
                    highlightElevation: 10,
                    backgroundColor: appColors.inkDark.withOpacity(0.7),
                    onPressed: _scrollToTop,
                    child: const Icon(
                      Icons.arrow_upward,
                      // size: 24 + (_animationController.value * 10),
                    ),
                  ),
                )
              : null),
    );
  }
}
