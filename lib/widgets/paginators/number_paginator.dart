import 'dart:math';

import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../screens/detail_story/widgets/chapter.dart';

class ListWithPaginator extends StatefulWidget {
  const ListWithPaginator();
  @override
  State<ListWithPaginator> createState() => _ListWithPaginatorState();
}

class _ListWithPaginatorState extends State<ListWithPaginator> {
  int currentPage = 0;
  int numOfPages = 2;
  int itemPerPage = 5;
  @override
  Widget build(BuildContext context) {
    //what in a page goes here
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
      'Tiêu đề chương',
      'Tiêu đề chương',
      'Tiêu đề chương',
      'Tiêu đề chương',
      'Tiêu đề chương'
    ];
    numOfPages = (CHAPTERS.length / itemPerPage).round();
    var pages = List.generate(
        numOfPages,
        (index) => (Container(
              child: Column(
                children: CHAPTERS
                    .sublist((index) * itemPerPage,
                        min((index + 1) * itemPerPage, CHAPTERS.length))
                    .asMap()
                    .entries
                    .map((entry) {
                  String chapterName = entry.value;
                  int i = index * itemPerPage + entry.key;
                  print((index) * itemPerPage);
                  print(min((index) * (itemPerPage + 1), CHAPTERS.length));
                  print('index ${index}');
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ChapterItem(
                        title: 'Chương ${i + 1}: ' + chapterName,
                        time: '20',
                      ));
                }).toList(),
              ),
            )));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 550,
            child: pages[currentPage],
          ),
          NumberPaginator(
            config: NumberPaginatorUIConfig(
                buttonSelectedBackgroundColor: Color(0xFF439A97),
                buttonUnselectedForegroundColor: Colors.black),
            numberPages: numOfPages,
            onPageChange: (index) {
              print(index);
              setState(() {
                currentPage = index;
              });
            },
          )
        ],
      ),
    );
  }
}
