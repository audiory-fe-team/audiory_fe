import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AppInfiniteScrollList<PageKeyType, ItemType> extends StatelessWidget {
  final Widget Function(BuildContext context, ItemType item, int index)
      itemBuilder;
  final Widget Function(BuildContext)? noItemsFoundIndicatorBuilder;
  final PagingController<PageKeyType, ItemType> controller;
  final List<Widget> topItems;

  const AppInfiniteScrollList(
      {super.key,
      required this.itemBuilder,
      required this.controller,
      this.noItemsFoundIndicatorBuilder,
      this.topItems = const []});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      ...topItems.map((item) => SliverToBoxAdapter(child: item)),
      PagedSliverList<PageKeyType, ItemType>(
          pagingController: controller,
          builderDelegate: PagedChildBuilderDelegate<ItemType>(
            itemBuilder: itemBuilder,
            noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder ??
                (context) {
                  return const Center(
                      child: Column(children: [
                    Icon(
                      Icons.find_in_page_outlined,
                      size: 36,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Danh sách trống.\n Chúng tôi không tìm thấy gì, \nquay lại sau nhé',
                      textAlign: TextAlign.center,
                    )
                  ]));
                },
          )),
    ]);
  }
}
