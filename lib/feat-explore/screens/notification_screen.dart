import 'package:audiory_v0/feat-explore/screens/layout/notification_top_bar.dart';
import 'package:audiory_v0/feat-explore/widgets/notification_card.dart';
import 'package:audiory_v0/models/notification/noti_model.dart';
import 'package:audiory_v0/repositories/notification_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/paginators/infinite_scroll_paginator.dart';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<Noti>?> notiData;
  static const _pageSize = 10;

  final PagingController<int, Noti> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await NotificationRepostitory.fetchNoties(
          offset: pageKey, limit: _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: const NotificationTopBar(),
        body: SafeArea(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: RefreshIndicator(
                onRefresh: () async {
                  _pagingController.refresh();
                },
                child: AppInfiniteScrollList(
                    itemBuilder: (context, item, index) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: NotificationCard(noti: item));
                    },
                    controller: _pagingController),
              )),
        ));
  }
}
