import 'package:audiory_v0/feat-read/screens/library/downloaded_stories.dart';
import 'package:audiory_v0/feat-read/screens/library/library_top_bar.dart';
import 'package:audiory_v0/feat-read/widgets/current_read_card.dart';
import 'package:audiory_v0/feat-read/widgets/reading_list_card.dart';
import 'package:audiory_v0/models/reading-list/reading_list_model.dart';
import 'package:audiory_v0/repositories/library_repository.dart';
import 'package:audiory_v0/repositories/reading_list_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fquery/fquery.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';

class LibraryScreen extends HookWidget {
  const LibraryScreen({super.key});
  static const tabs = ['Đang đọc', 'Danh sách đọc', 'Tải xuống'];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    final tabState = useState(0);

    return Scaffold(
        appBar: const LibraryTopBar(),
        body: Material(
            color: Colors.transparent,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: tabs.asMap().entries.map((entry) {
                        final index = entry.key;
                        final tabName = entry.value;
                        return InkWell(
                            onTap: () {
                              tabState.value = index;
                            },
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: index == tabState.value
                                                ? appColors.primaryBase
                                                : Colors.transparent,
                                            width: 2))),
                                child: Text(
                                  tabName,
                                  style: textTheme.titleMedium,
                                )));
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                        child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 0),
                      child: Builder(
                        builder: (context) {
                          if (tabState.value == 1) return ReadingLists();
                          if (tabState.value == 2) {
                            return const DownloadedStories();
                          }
                          return const CurrentReadings();
                        },
                      ),
                    )),
                  ],
                ))));
  }
}

class ReadingLists extends HookWidget {
  ReadingLists({super.key});
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final AppColors? appColors = Theme.of(context).extension<AppColors>();
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final readingListQuery = useQuery(
        ['readingList'], () => ReadingListRepository.fetchMyReadingList());

    handleCreateReadingList() async {
      Map<String, String> body = {};

      const storage = FlutterSecureStorage();
      final jwtToken = await storage.read(key: 'jwt');
      final userId = JwtDecoder.decode(jwtToken as String)['user_id'];
      body['user_id'] = userId;
      body['name'] = _formKey.currentState?.fields['name']?.value;
      body['is_private'] = 'true';
      ReadingList? readingList;
      try {
        readingList = await ReadingListRepository.addReadingList(
            body, _formKey.currentState?.fields['photo']?.value);
        await AppSnackBar.buildTopSnackBar(
            context, 'Tạo thành công', null, SnackBarType.success);
        readingListQuery.refetch();
      } catch (error) {
        // ignore: use_build_context_synchronously
        AppSnackBar.buildTopSnackBar(
            context, 'Tạo thất bại', null, SnackBarType.error);
      }
    }

    handleDeleteReadingList(String readingListId) async {
      try {
        await ReadingListRepository.deleteReadingList(readingListId);
        // ignore: use_build_context_synchronously
        context.pop();
        readingListQuery.refetch();
      } catch (error) {
        AppSnackBar.buildTopSnackBar(
            context, 'Xóa thất bại', null, SnackBarType.error);
      }
      // ignore: use_build_context_synchronously
      AppSnackBar.buildTopSnackBar(
          context, 'Xóa thành công', null, SnackBarType.success);
    }

    handlePublishReadingList(String readingListId, bool isPrivate) async {
      const storage = FlutterSecureStorage();
      final jwtToken = await storage.read(key: 'jwt');
      final userId = JwtDecoder.decode(jwtToken as String)['user_id'];

      Map<String, String> body = {};
      body['user_id'] = userId;
      body['is_private'] = '${!isPrivate}';

      try {
        await ReadingListRepository.editReadingList(readingListId, body, []);

        readingListQuery.refetch();
      } catch (error) {
        AppSnackBar.buildTopSnackBar(
            context, 'Sửa thất bại', null, SnackBarType.error);
      }
      // ignore: use_build_context_synchronously
      AppSnackBar.buildTopSnackBar(
          context, 'Sửa thành công', null, SnackBarType.success);
    }

    handleEditReadingList(String readingListId, name, formFile) async {
      Map<String, String> body = {};
      body['name'] = name;

      try {
        await ReadingListRepository.editReadingList(
            readingListId, body, formFile);
        readingListQuery.refetch();
      } catch (error) {
        AppSnackBar.buildTopSnackBar(
            context, 'Sửa thất bại', null, SnackBarType.error);
      }

      // ignore: use_build_context_synchronously
      AppSnackBar.buildTopSnackBar(
          context, 'Sửa thành công', null, SnackBarType.success);
    }

    return Expanded(
        child: Skeletonizer(
            enabled: readingListQuery.isFetching,
            child: RefreshIndicator(
                onRefresh: () async {
                  readingListQuery.refetch();
                },
                child: ListView(children: [
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  scrollable: true,
                                  title: Column(children: [
                                    Text(
                                      'Tạo một danh sách đọc',
                                      style: textTheme.titleLarge?.copyWith(
                                          color: appColors?.inkDarkest),
                                    ),
                                    Text(
                                      'Đặt tên cho danh sách đọc của bạn',
                                      style: textTheme.bodyMedium?.copyWith(
                                          color: appColors?.inkLight),
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                                  content: SizedBox(
                                    width: size.width / 2,
                                    height: size.height / 2.8,
                                    child: FormBuilder(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: size.width / 4,
                                            child: FormBuilderImagePicker(
                                                initialValue: [],
                                                previewAutoSizeWidth: true,
                                                maxImages: 1,
                                                backgroundColor: appColors
                                                    ?.skyLightest,
                                                iconColor: appColors
                                                    ?.primaryBase,
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            InputBorder.none),
                                                name: 'photo'),
                                          ),
                                          SizedBox(
                                            height: 70,
                                            child: AppTextInputField(
                                              hintText:
                                                  'Ví dụ: Truyện trinh thám hay',
                                              name: 'name',
                                              validator: FormBuilderValidators
                                                  .required(
                                                      errorText:
                                                          'Không được để trống'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                    width: 100,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        context.pop();
                                                      },
                                                      child: Text(
                                                        'Hủy',
                                                        style: textTheme
                                                            .titleMedium,
                                                      ),
                                                    )),
                                                SizedBox(
                                                    width: 100,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        //check if input validate
                                                        final isValid = _formKey
                                                            .currentState
                                                            ?.validate();

                                                        if (isValid != null &&
                                                            isValid) {
                                                          _formKey.currentState
                                                              ?.save();
                                                          context.pop();
                                                          handleCreateReadingList();
                                                        }
                                                        // context.pop();
                                                      },
                                                      child: Text(
                                                        'Tạo',
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: textTheme.titleMedium?.copyWith(
                                                            color: _formKey
                                                                        .currentState
                                                                        ?.validate() ==
                                                                    true
                                                                ? appColors
                                                                    ?.primaryBase
                                                                : appColors
                                                                    ?.inkLighter),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              // handleCreateReadingList();
                            },
                            child: Skeleton.shade(
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: appColors?.skyLightest,
                                      borderRadius: BorderRadius.circular(28)),
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                            Text('Tạo danh sách đọc',
                                                style: textTheme.titleMedium
                                                    ?.copyWith(
                                                        color: appColors
                                                            ?.inkLight)),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Icon(Icons.add_rounded,
                                                size: 14,
                                                color: appColors?.inkBase),
                                          ])))),
                            ))
                      ]),
                  const SizedBox(height: 16),
                  ...(readingListQuery.data ?? [])
                      .map((e) => Container(
                          key: ValueKey(e.createdDate),
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ReadingListCard(
                            readingList: e,
                            onDeleteReadingList: (readingListId) {
                              handleDeleteReadingList(readingListId);
                            },
                            onPublishHandler: (readingListId) {
                              handlePublishReadingList(
                                  readingListId, e.isPrivate ?? true);
                            },
                            onEditHandler: (readingListId, name, formFile) {
                              handleEditReadingList(
                                  readingListId, name, formFile);
                            },
                          )))
                      .toList()

                  // ..sort((a, b) {
                  //   print(a.key.toString());
                  //   print(b.key.toString());
                  //   final d1 = DateTime.parse(a.key.toString());
                  //   final d2 = DateTime.parse(b.key.toString());

                  //   final compare = d1.isAfter(d2) ? 1 : 0;
                  //   return compare;
                  // },
                  // ),
                ]))));
  }
}

class CurrentReadings extends HookWidget {
  const CurrentReadings({super.key});

  @override
  Widget build(BuildContext context) {
    final libraryQuery = useQuery(
      ['library'],
      () => LibraryRepository.fetchMyLibrary(),
      refetchOnMount: RefetchOnMount.stale,
      staleDuration: const Duration(minutes: 5),
    );

    handleDeleteStory(String id) async {
      try {
        await LibraryRepository.deleteStoryFromMyLibrary(id);
      } catch (error) {
        AppSnackBar.buildTopSnackBar(
            context, 'Xóa thất bại, thử lại sau.', null, SnackBarType.error);
      }
      libraryQuery.refetch();
      await AppSnackBar.buildTopSnackBar(
          context, 'Xóa thành công.', null, SnackBarType.success);
    }

    return Expanded(
      child: Skeletonizer(
        enabled: libraryQuery.isFetching,
        child: RefreshIndicator(
          onRefresh: () async {
            libraryQuery.refetch();
          },
          child: ListView(
              children: (libraryQuery.data?.libraryStory ?? [])
                  .map((e) => Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: CurrentReadCard(
                        libStory: e,
                        onDeleteStory: (id) => handleDeleteStory(id),
                      )))
                  .toList()),
        ),
      ),
    );
  }
}
