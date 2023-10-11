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
            noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
          )),
    ]);
  }
}
