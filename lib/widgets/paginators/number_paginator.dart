import 'dart:math';

import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../feat-read/widgets/chapter_item.dart';

class ListWithPaginator extends StatefulWidget {
  const ListWithPaginator({super.key});
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
    // ignore: constant_identifier_names
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
        (index) => (Column(
              children: CHAPTERS
                  .sublist((index) * itemPerPage,
                      min((index + 1) * itemPerPage, CHAPTERS.length))
                  .asMap()
                  .entries
                  .map((entry) {
                String chapterName = entry.value;
                int i = index * itemPerPage + entry.key;

                return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ChapterItem(
                      onSelected: (_, __) {},
                      title: 'Chương ${i + 1}: $chapterName',
                      time: '20',
                    ));
              }).toList(),
            )));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 550,
            child: pages[currentPage],
          ),
          NumberPaginator(
            config: const NumberPaginatorUIConfig(
                buttonSelectedBackgroundColor: Color(0xFF439A97),
                buttonUnselectedForegroundColor: Colors.black),
            numberPages: numOfPages,
            onPageChange: (index) {
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
