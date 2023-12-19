import 'package:audiory_v0/feat-manage-profile/screens/level/level_instruction.dart';
import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/author_level.dart/author_level_model.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/models/level/level_model.dart';
import 'package:audiory_v0/repositories/profile_repository.dart';
import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:audiory_v0/widgets/custom_app_bar.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyLevelScreen extends StatefulWidget {
  final Level? level;
  final AuthorLevel? authorLevel;
  final bool? isAuthorFlairSelected;
  final Function callback;
  const MyLevelScreen(
      {super.key,
      this.level,
      this.authorLevel,
      this.isAuthorFlairSelected = false,
      required this.callback});

  @override
  State<MyLevelScreen> createState() => _MyLevelScreenState();
}

class _MyLevelScreenState extends State<MyLevelScreen> {
  bool selectAuthorLevel = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectAuthorLevel = widget.isAuthorFlairSelected == true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final AuthorLevel? authorLevel = widget.authorLevel;
    final Level? level = widget.level;

    final double levelSize = size.width / 2.5;
    BoxDecoration selectedDecoration() {
      return BoxDecoration(
          color: appColors.primaryLightest,
          border: Border.all(color: appColors.primaryDark, width: 2),
          borderRadius: BorderRadius.circular(12));
    }

    Widget authorLevelCard() {
      return Column(
        children: [
          Container(
              decoration: selectAuthorLevel ? selectedDecoration() : null,
              child: Image.asset(
                authorLevel?.id == 1
                    ? 'assets/images/author_level_1.png'
                    : authorLevel?.id == 2
                        ? 'assets/images/author_level_2.png'
                        : 'assets/images/author_level_3.png',
                width: levelSize,
                height: levelSize,
              )),
          Text(
            '${authorLevel?.name}',
            style: textTheme.titleLarge,
          )
        ],
      );
    }

    Widget levelCard() {
      return Column(
        children: [
          Container(
            decoration: selectAuthorLevel ? null : selectedDecoration(),
            child: Image.asset(
              level?.id == 1
                  ? 'assets/images/level_bronze.png'
                  : level?.id == 2
                      ? 'assets/images/level_silver.png'
                      : 'assets/images/level_gold.png',
              width: levelSize,
              height: levelSize,
            ),
          ),
          Text(
            'Hạng ${level?.name?.toLowerCase()}',
            style: textTheme.titleLarge,
          )
        ],
      );
    }

    updateFlair() async {
      Profile? newProfile = await ProfileRepository()
          .updateProfile(
            null,
            {'is_author_flair_selected': '$selectAuthorLevel'},
          )
          .then((value) {})
          .whenComplete(() {});

      // ignore: use_build_context_synchronously
      context.pop();
      // ignore: use_build_context_synchronously
      AppSnackBar.buildTopSnackBar(
          context, 'Đổi huy hiệu thành công', null, SnackBarType.success);

      widget.callback();
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Thứ hạng của tôi'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: LevelInstruction(),
                      );
                    });
              },
              icon: const Icon(
                Icons.question_mark_outlined,
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // SizedBox(
          //   width: size.width - 32,
          //   height: size.height / 5,
          //   child: Text(
          //     'Bạn có thể chọn khung thứ hạng để hiển thị',
          //     style: textTheme.titleMedium,
          //   ),
          // ),
          SizedBox(
            width: double.infinity,
            child: Column(children: [
              // Text(
              //   'Bạn có thể chọn khung thứ hạng để hiển thị',
              //   style: textTheme.titleLarge,
              // ),
              //  SizedBox(
              //   height: size.height / 16,
              // ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectAuthorLevel = false;
                  });
                  updateFlair();
                },
                child: levelCard(),
              ),
              SizedBox(
                height: size.height / 16,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      selectAuthorLevel = true;
                    });
                    updateFlair();
                  },
                  child: authorLevelCard())
            ]),
          )
        ],
      ),
    );
  }
}
