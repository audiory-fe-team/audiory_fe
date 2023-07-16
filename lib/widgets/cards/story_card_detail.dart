import 'package:audiory_v0/models/Story.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoryCardDetail extends StatelessWidget {
  final Story story;

  const StoryCardDetail({required this.story});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 135,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 95,
                  height: 135,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(story.coverUrl ?? ''),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            story.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            story.description ?? '',
                            maxLines: 2,
                            style: const TextStyle(
                              color: Color(0xFF6C7072),
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/icons/write.svg',
                                        width: 14, height: 14),
                                    const SizedBox(width: 8),
                                    Text(
                                      story.authorName ?? '',
                                      style: const TextStyle(
                                        color: Color(0xFF25282B),
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/heart.svg',
                                              width: 14,
                                              height: 14),
                                          const SizedBox(width: 3),
                                          Text(
                                            story.voteCount.toString() ??
                                                'error',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/icons/chapter.svg',
                                        width: 14, height: 14),
                                    const SizedBox(width: 8),
                                    Text(
                                      (story.numChapter.toString() ?? 'error') +
                                          ' chương',
                                      style: TextStyle(
                                        color: Color(0xFF25282B),
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.02,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/icons/eye.svg',
                                        width: 14, height: 14),
                                    const SizedBox(width: 8),
                                    Text(
                                      story.readCount.toString() ?? 'error',
                                      style: TextStyle(
                                        color: Color(0xFF25282B),
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.02,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          decoration: const BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF6F8F9),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hoàn thành',
                                      style: TextStyle(
                                        color: Color(0xFF979C9E),
                                        fontSize: 8,
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.01,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF6F8F9),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lãng mạn',
                                      style: TextStyle(
                                        color: Color(0xFF979C9E),
                                        fontSize: 8,
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.01,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF6F8F9),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nhẹ nhàng',
                                      style: TextStyle(
                                        color: Color(0xFF979C9E),
                                        fontSize: 8,
                                        fontFamily: 'Source Sans Pro',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.01,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
