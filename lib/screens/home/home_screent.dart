import 'package:audiory_v0/models/Story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreeen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: SafeArea(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.amber,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        child: const CircleAvatar(
                          backgroundImage:
                              const AssetImage('assets/images/user-avatar.jpg'),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                        height: 10,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Xin chào',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'John Doe',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          print('haha');
                        },
                        child: SvgPicture.asset(
                          'assets/icons/search.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        child: SvgPicture.asset(
                          'assets/icons/notification on.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                ]),
          )),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: ListView(
              children: [
                Banners(),
                SizedBox(height: 32),
                HomeRecommendations(),
                SizedBox(height: 32),
                HomeRankingList(),
              ],
            )),
      ),
    );
  }
}

class Banners extends StatelessWidget {
  final BANNERS_LIST = [
    'https://t3.ftcdn.net/jpg/03/21/97/42/360_F_321974259_BnmlxfkknMol8HiQ0dg1bwQizor48uB9.jpg',
    'https://t3.ftcdn.net/jpg/03/21/97/42/360_F_321974259_BnmlxfkknMol8HiQ0dg1bwQizor48uB9.jpg',
    'https://t3.ftcdn.net/jpg/03/21/97/42/360_F_321974259_BnmlxfkknMol8HiQ0dg1bwQizor48uB9.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 122,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: BANNERS_LIST.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.only(right: 16),
                child: Container(
                  width: 240,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      BANNERS_LIST[index],
                      fit: BoxFit.fill,
                    ),
                  ),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ));
          }),
    );
  }
}

class HomeHeaders extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String link;

  const HomeHeaders(
      {this.icon = null, required this.title, required this.link});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              icon ?? Container(),
              SizedBox(width: 6),
              Text(title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
          Text('Thêm',
              style: TextStyle(
                color: Color(0xFF439A97),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ))
        ],
      ),
    );
  }
}

class HomeStoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const HomeStoryCard({this.title = '', this.imageUrl = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 95,
            height: 135,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage(this.imageUrl),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              shadows: [
                BoxShadow(
                  color: Color(0x0C06070D),
                  blurRadius: 14,
                  offset: Offset(0, 7),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 95,
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    this.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF404446),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeRecommendations extends StatelessWidget {
  final List<Story> STORY_LIST = [
    Story('https://via.placeholder.com/95x135', 'Vs'),
    Story('https://via.placeholder.com/95x135',
        'VErrry long asdasdasdasdlqwelqweasdlasldlqwleqlwelqweqw'),
    Story('https://via.placeholder.com/95x135', 'Mùa hè cuối cùng ta và em'),
    Story('https://via.placeholder.com/95x135', 'Ngôi sao biến mất'),
    Story('https://via.placeholder.com/95x135', 'Con ngựa đỏ'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      HomeHeaders(title: 'Có thể bạn sẽ thích', link: ''),
      SizedBox(height: 12),
      Container(
          width: double.infinity,
          height: 180,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: STORY_LIST.length,
              itemBuilder: (BuildContext context, int index) {
                Story story = STORY_LIST[index];
                return Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: HomeStoryCard(
                      title: story.title, imageUrl: story.imageUrl),
                );
              })),
    ]);
  }
}

class RankingListBadge extends StatelessWidget {
  final String label;
  final bool selected;

  const RankingListBadge({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: ShapeDecoration(
        color: selected ? Color(0xFF439A97) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Color(0xFFFFFDFD) : Color(0xFF404446),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeRankingList extends StatelessWidget {
  static const OPTIONS = ['Truyện hot tháng', 'Truyện bình luận nhiều'];
  final List<Story> LISTS = [
    Story('https://via.placeholder.com/95x135', 'Vs'),
    Story('https://via.placeholder.com/95x135',
        'VErrry long asdasdasdasdlqwelqweasdlasldlqwleqlwelqweqw'),
    Story('https://via.placeholder.com/95x135', 'Mùa hè cuối cùng ta và em'),
    Story('https://via.placeholder.com/95x135', 'Ngôi sao biến mất'),
    Story('https://via.placeholder.com/95x135', 'Con ngựa đỏ'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        HomeHeaders(title: 'BXH Tháng này', link: ''),
        SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: OPTIONS
                .map((option) => Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: RankingListBadge(
                      label: option,
                      selected: true,
                    )))
                .toList(),
          ),
        ),
        SizedBox(height: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: LISTS.asMap().entries.map((entry) {
            Story story = entry.value;
            int index = entry.key;
            return Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: HomeRankingCard(
                  order: index,
                  title: story.title,
                  imageUrl: story.imageUrl,
                  icon: InkWell(
                    child: SvgPicture.asset(
                      'assets/icons/heart.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ));
          }).toList(),
        ),
      ]),
    );
  }
}

class HomeRankingCard extends StatelessWidget {
  final int order;
  final String imageUrl;
  final String title;
  final Widget icon;

  const HomeRankingCard(
      {required this.order,
      required this.imageUrl,
      required this.title,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            child: Image.asset(
              'assets/images/silver_badge.png',
            ),
          ),
          SizedBox(width: 12),
          Container(
            width: 50,
            height: 70,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: NetworkImage("https://via.placeholder.com/50x70"),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              shadows: [
                BoxShadow(
                  color: Color(0x0C06070D),
                  blurRadius: 14,
                  offset: Offset(0, 7),
                  spreadRadius: 0,
                )
              ],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
              child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    this.title,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/heart.svg',
                        width: 8,
                        height: 8,
                        color: Color(0xFF979C9E),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '12,000',
                        style: TextStyle(
                          color: Color(0xFF979C9E),
                          fontSize: 10,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

// class PaidStories extends StatelessWidget
