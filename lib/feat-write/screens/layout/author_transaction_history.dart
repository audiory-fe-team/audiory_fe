import 'package:audiory_v0/feat-manage-profile/widgets/transaction_card.dart';
import 'package:audiory_v0/models/enums/TransactionType.dart';
import 'package:audiory_v0/models/transaction/transaction_model.dart';
import 'package:audiory_v0/repositories/transaction_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/utils/use_paging_controller.dart';
import 'package:audiory_v0/widgets/paginators/infinite_scroll_paginator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AuthorTransactionHistory extends HookWidget {
  const AuthorTransactionHistory({
    super.key,
  });
  static const _pageSize = 100;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    const transactionTypeList = [
      TransactionType.ALL,
      TransactionType.REWARD_FROM_GIFT,
      TransactionType.REWARD_FROM_STORY,
      TransactionType.WITHDRAW,
    ];
    final selectedType =
        useState<TransactionType>(TransactionType.REWARD_FROM_GIFT);

    final PagingController<int, Transaction> transactionsPagingController =
        usePagingController(
            firstPageKey: 0,
            onPageRequest: (int pageKey,
                PagingController<int, Transaction> pagingController) async {
              try {
                final newItems =
                    await TransactionRepository.fetchMyTransactions(
                            page: pageKey,
                            pageSize: 20,
                            type: selectedType.value.name == 'ALL'
                                ? null
                                : selectedType.value) ??
                        [];

                final isLastPage = newItems.length < _pageSize;
                if (isLastPage) {
                  pagingController.appendLastPage(newItems);
                } else {
                  final nextPageKey = pageKey + newItems.length;
                  pagingController.appendPage(newItems, nextPageKey);
                }
              } catch (error) {
                pagingController.error = error;
              }
            });
    return HookBuilder(
      builder: (context) {
        return Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              transactionsPagingController.refresh();
            },
            child: AppInfiniteScrollList(
                topItems: [
                  Container(
                    width: size.width,
                    height: 60,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: transactionTypeList.length,
                        itemBuilder: (context, index) {
                          //find first of the month
                          bool isSelected = selectedType.value.name ==
                              transactionTypeList[index].name;

                          TransactionType type = transactionTypeList[index];
                          return GestureDetector(
                            onTap: () {
                              selectedType.value = type;
                              transactionsPagingController.refresh();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 2),
                              margin: const EdgeInsets.only(
                                  right: 4, top: 16, bottom: 16),
                              decoration: BoxDecoration(
                                  color: isSelected
                                      ? appColors.primaryBase
                                      : appColors.skyLightest,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Text(
                                  type.displayText,
                                  style: textTheme.titleSmall?.copyWith(
                                      color: isSelected
                                          ? appColors.skyLightest
                                          : appColors.inkLighter,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
                itemBuilder: (context, item, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TransactionCard(transaction: item)),
                controller: transactionsPagingController),
          ),
        );
      },
    );
  }
}
