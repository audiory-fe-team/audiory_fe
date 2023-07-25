import 'package:audiory_v0/models/Chapter.dart';
import 'package:audiory_v0/screens/detail_story/detail_story_mock.dart';
import 'package:audiory_v0/screens/detail_story/widgets/chapter.dart';
import 'package:audiory_v0/screens/detail_story/widgets/commentCard.dart';
import 'package:audiory_v0/screens/detail_story/widgets/detail_story_bottom_bar.dart';
import 'package:audiory_v0/screens/detail_story/widgets/supporterCard.dart';
import 'package:audiory_v0/widgets/paginators/number_paginator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../theme/theme_constants.dart';
import '../../widgets/category_badge.dart';

class DetailStoryScreen extends StatefulWidget {
  final String? id;
  const DetailStoryScreen({super.key, required this.id});

  @override
  State<DetailStoryScreen> createState() => _DetailStoryScreenState();
}

class _DetailStoryScreenState extends State<DetailStoryScreen>
    with TickerProviderStateMixin {
  Widget _storyCover() {
    return Container(
      width: 110,
      height: 165,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://t3.ftcdn.net/jpg/03/21/97/42/360_F_321974259_BnmlxfkknMol8HiQ0dg1bwQizor48uB9.jpg'),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [
          BoxShadow(
            color: Color(0x0C06070D),
            blurRadius: 14,
            offset: Offset(0, 7),
            spreadRadius: 0,
          )
        ],
      ),
    );
  }

  Widget _authorInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          child: InkWell(
            onTap: () async {
              context.go('/profile');
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90),
            ),
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(50.0),
              child: Image.asset('assets/images/user-avatar.jpg',
                  width: 40.0, height: 40.0),
            ),
          ),
        ),
        Text('Author name')
      ],
    );
  }

  Widget _storyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _storyCover(),
        Padding(padding: EdgeInsets.symmetric(vertical: 12)),
        Text(
          '${widget.id}',
          textAlign: TextAlign.center,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 12)),
        _authorInfo(),
      ],
    );
  }

  Widget _interactionInfo() {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: INTERACTIONS
          .map((item) => Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Column(
                  children: [
                    Row(
                      children: [item.icon, Text(item.key)],
                    ),
                    Text(item.value as String)
                  ],
                ),
              ))
          .toList(),

      // children: [
      //   Column(
      //     children: [
      //       Row(
      //         children: [Icon(Icons.list), Text('Chuong')],
      //       ),
      //       Text('76')
      //     ],
      //   )
      // ],
    ));
  }

  //tab
  Widget _supporterList() {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    const SUPPORTERS = [
      22000,
      12220,
      4420,
      199,
      190,
      120,
    ];
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: SUPPORTERS.asMap().entries.map((entry) {
            int score = entry.value;
            int index = entry.key;
            return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SupporterCard(
                  name: 'Default name',
                  rank: index + 1,
                  score: score,
                ));
          }).toList(),
        ),
        Center(
          child: Text(
            'Bảng xếp hạng fan',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                decoration: TextDecoration.underline,
                color: appColors.primaryDark),
          ),
        )
      ],
    ));
  }

  Widget _commentList() {
    const COMMENTS = [1200, 1220, 1220];
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: COMMENTS.asMap().entries.map((entry) {
            String score = '${entry.value}';
            int index = entry.key;
            return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CommentCard(
                  name: 'Default name',
                  time: '12 giờ trước',
                  image: '',
                  content: 'Hay ',
                ));
          }).toList(),
        ),
      ],
    ));
  }

  Widget _detailLeftTabView() {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
        ),
        Text(
          'Giới thiệu',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          style: TextStyle(color: Color(0xFF404446)),
          textAlign: TextAlign.justify,
        ),
        SizedBox(
          height: 24,
        ),
        Text(
          'Người ủng hộ',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        _supporterList(),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bình luận nổi bật',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              child: SvgPicture.asset(
                'assets/icons/right-arrow.svg',
                width: 24,
                height: 24,
                color: appColors.inkDark,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        _commentList()
      ],
    );
  }

  Widget _chapterRightTabView() {
    const CHAPTERS = [
      'Tiêu đề chương',
      'Tiêu đề chương',
      'Tiêu đề chương',
      'Tiêu đề chương',
      'Tiêu đề chương',
      'Tiêu đề chương',
      'Tiêu đề chương',
      'Tiêu đề chương',
      'Tiêu đề chương',
      'Tiêu đề chương'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Cập nhật đến chương',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              child: Row(children: [
                Text(
                  'Mới nhất',
                  style: TextStyle(color: const Color(0xFF439A97)),
                ),
                SizedBox(
                  width: 4,
                ),
                Text('Cũ nhất')
              ]),
            ),
          ],
        ),
        // Column(
        //   children: CHAPTERS.asMap().entries.map((entry) {
        //     String chapterName = entry.value;
        //     int index = entry.key;
        //     return Padding(
        //         padding: const EdgeInsets.only(bottom: 12),
        //         child: ChapterItem(
        //           title: 'Chương ${index + 1}: ' + chapterName,
        //           time: '20',
        //         ));
        //   }).toList(),
        // ),
        ListWithPaginator()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = new TabController(length: 2, vsync: this);
    const OPTIONS = [
      'Top 2 bí ẩn tuần',
      'Đang ra',
      'Bí ẩn',
      'Trinh thám',
      'Lạ lùng',
      'Kịch tính',
      'Cổ điển'
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => context.go('/'),
            child: Icon(Icons.arrow_back),
          ),
          title: Text(
            '${widget.id}',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            GestureDetector(
              child: Icon(Icons.more_vert_sharp),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text('detail ${widget.id}'),
              _storyInfo(),
              Padding(padding: EdgeInsets.symmetric(vertical: 24)),

              _interactionInfo(),
              Padding(padding: EdgeInsets.symmetric(vertical: 24)),

              SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    spacing: 4,
                    runSpacing: 12,
                    children: OPTIONS
                        .map((option) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: RankingListBadge(
                              label: option,
                              selected: false,
                            )))
                        .toList(),
                  )),

              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                child: TabBar(
                  controller: _tabController,
                  labelColor: const Color(0xFF439A97),
                  unselectedLabelColor: Colors.blueGrey,
                  labelPadding: EdgeInsets.symmetric(horizontal: 16),
                  indicatorColor: const Color(0xFF439A97),
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      text: 'Chi tiết',
                    ),
                    Tab(
                      text: 'Chương',
                    )
                  ],
                ),
              ),

              Container(
                height: 1000,
                child: TabBarView(
                    controller: _tabController,
                    children: [_detailLeftTabView(), _chapterRightTabView()]),
              )
            ],
          ),
        ),
        bottomNavigationBar: const DetailStoryBottomBar(),
      ),
    );
  }
}
