import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/providers/global_me_provider.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/cards/app_avatar_image.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FollowersScrollList extends StatefulHookConsumerWidget {
  final List<Profile>? profileList;
  final String? title;
  const FollowersScrollList({
    super.key,
    this.profileList = const [],
    this.title = 'Danh sách',
  });

  @override
  ConsumerState<FollowersScrollList> createState() =>
      _FollowersScrollListState();
}

class _FollowersScrollListState extends ConsumerState<FollowersScrollList> {
  final _searchFormKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final currentUserId = ref.watch(globalMeProvider)?.id;

    List<Profile>? list = widget.profileList;
    final searchValue = _searchFormKey.currentState?.fields['search']?.value
            ?.toString()
            .trim()
            .toLowerCase() ??
        '';

    final filteredList = searchValue == ''
        ? (list ?? [])
        : (list ?? []).where((element) =>
            (element.fullName?.toLowerCase().trim().contains(searchValue) ??
                false) ||
            (element.username?.toLowerCase().trim().contains(searchValue) ??
                false));
    print('search ${searchValue}');
    print((list ?? []).where((element) => (element.username
            ?.toLowerCase()
            .trim()
            .contains(
                _searchFormKey.currentState?.fields['search']?.value ?? '') ??
        false)));
    return Scaffold(
      appBar: CustomAppBar(
          title: Text(
        widget.title ?? 'Danh sách',
        style: textTheme.headlineSmall,
      )),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            list?.isEmpty == true
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: Text(
                        'Chưa có người nào trong danh sách',
                        style: textTheme.titleMedium,
                      ),
                    ),
                  )
                : FormBuilder(
                    key: _searchFormKey,
                    onChanged: () {
                      setState(() {
                        _searchFormKey.currentState?.save();
                      });
                    },
                    child: AppTextInputField(
                      name: 'search',
                      hintText: 'Tìm kiếm',
                      prefixIcon: Icon(
                        Icons.search,
                        color: appColors.skyDark,
                      ),
                    )),
            const SizedBox(height: 16),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    if (list?.isEmpty == true) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: Text(
                            'Chưa có người nào trong danh sách',
                            style: textTheme.titleMedium,
                          ),
                        ),
                      );
                    }

                    Profile? profile = list?[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                flex: 1,
                                child: AppAvatarImage(
                                  size: 40,
                                  url: profile?.avatarUrl,
                                )),
                            Flexible(
                                flex: 5,
                                child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          profile?.fullName ?? 'Người dùng',
                                          style: textTheme.titleMedium,
                                        ),
                                        Text(
                                          '@${profile?.username ?? 'tendangnhap'}',
                                          style: textTheme.titleSmall?.copyWith(
                                              color: appColors.inkLighter),
                                        ),
                                      ],
                                    ))),
                          ]),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
