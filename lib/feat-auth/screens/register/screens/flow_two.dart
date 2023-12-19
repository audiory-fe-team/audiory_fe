import 'package:audiory_v0/models/Profile.dart';
import 'package:audiory_v0/models/enums/Sex.dart';
import 'package:audiory_v0/models/enums/SnackbarType.dart';
import 'package:audiory_v0/repositories/profile_repository.dart';
import 'package:audiory_v0/utils/format_date.dart';
import 'package:audiory_v0/widgets/buttons/app_icon_button.dart';
import 'package:audiory_v0/widgets/input/text_input.dart';
import 'package:audiory_v0/widgets/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../theme/theme_constants.dart';

class FlowTwoScreen extends StatefulWidget {
  final String userId;
  const FlowTwoScreen({super.key, required this.userId});

  @override
  State<FlowTwoScreen> createState() => _FlowTwoScreenState();
}

class _FlowTwoScreenState extends State<FlowTwoScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  String _selectedDate = (String? date) {
    //use package intl
    DateTime dateTime = DateTime.parse(date as String);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }(DateTime(2000, 1, 1).toIso8601String());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    DateTime? datepicked;

    String formatDate(String? date) {
      //use package intl
      DateTime dateTime = DateTime.parse(date as String);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }

    Future<void> showdobpicker() async {
      datepicked = await showDatePicker(
          helpText: 'Chọn ngày sinh',
          context: context,
          initialDate: DateTime(2000, 1, 1),
          firstDate: DateTime(1933, 1, 1),
          lastDate: DateTime(2017, 1, 1),
          //initial entry : calendar picker or input
          initialEntryMode: DatePickerEntryMode.input,
          confirmText: 'Chọn',
          cancelText: 'Hủy',
          fieldHintText: '01/01/2002',
          fieldLabelText: 'Nhập ngày',
          errorInvalidText: 'Năm sinh trong khoảng 1933-2017',
          errorFormatText: 'Lỗi định dạng (dd/MM/yyyy)',
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme(
                    primary: appColors.primaryBase,
                    onPrimary: appColors.skyLightest,
                    secondary: appColors.primaryBase,
                    onSecondary: appColors.primaryBase,
                    error: Colors.red,
                    onError: Colors.red,
                    background: appColors.primaryBase,
                    onBackground: appColors.primaryBase,
                    surface: appColors.skyLightest,
                    onSurface: appColors.primaryBase,
                    brightness: Brightness.light),
                buttonBarTheme: const ButtonBarThemeData(
                    buttonTextTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          });
      // ignore: unrelated_type_equality_checks
      if (datepicked != null) {
        setState(() {
          _selectedDate = formatDate(datepicked!.toString());
        });
      }
    }

    Widget timePickerWidget() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Chọn ngày sinh của bạn*",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: appColors.inkDarkest)),
                    Text("Chọn độ tuổi để có gợi ý truyện phù hợp",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: appColors.inkLight)),
                  ],
                ),
              ),
              // Flexible(
              //   flex: 1,
              //   child: GestureDetector(
              //       onTap: () {
              //         showdobpicker();
              //       },
              //       child: Padding(
              //         padding: const EdgeInsets.only(right: 8.0),
              //         child: Icon(
              //           Icons.calendar_today,
              //           color: appColors.skyDark,
              //           size: 26,
              //         ),
              //       )),
              // ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          AppTextInputField(
            name: 'dob',
            hintText: _selectedDate,
            suffixIcon: IconButton(
              onPressed: () {
                showdobpicker();
              },
              icon: Icon(Icons.calendar_today),
            ),
            hintTextStyle: TextStyle(color: appColors.inkBase),
          ),
          const SizedBox(
            height: 16,
          )
        ],
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(''),
          elevation: 0,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: size.height,
          width: size.width,
          child: FormBuilder(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 3,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Chọn giới tính của bạn*",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: appColors.inkDarker)),
                      Text("Chọn giới tính để có gợi ý truyện phù hợp",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: appColors.inkLight)),
                      FormBuilderRadioGroup(
                          separator: const SizedBox(height: 10),
                          orientation: OptionsOrientation.vertical,
                          name: 'sex',
                          activeColor: appColors.primaryBase,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          initialValue: 'MALE',
                          options: List.generate(
                              Sex.values.length,
                              (index) => FormBuilderFieldOption(
                                    value: Sex.values[index].name,
                                    child: Text(
                                      Sex.values[index].displayTitle,
                                      style: textTheme.titleLarge?.copyWith(
                                          color: appColors.inkDarker),
                                    ),
                                  ))),
                    ]),
              ),
              Expanded(
                flex: 4,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.0)),
                      timePickerWidget(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: size.width / 1,
                                  height: size.height / 4.5,
                                  child: const Image(
                                      height: double.maxFinite,
                                      image: AssetImage(
                                          'assets/images/skate_man.png'))),
                            ]),
                      )
                    ]),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 32,
                        child: AppIconButton(
                          title: "Tiếp tục",
                          onPressed: () async {
                            //save
                            if (_formKey.currentState?.validate() == true) {
                              _formKey.currentState?.save();

                              Map<String, String> body = {};

                              body['sex'] =
                                  _formKey.currentState?.fields['sex']?.value;

                              body['dob'] =
                                  appFormatDateFromDatePicker(_selectedDate);

                              //update new user data
                              Profile? updatedProfile =
                                  await ProfileRepository()
                                      .updateNewUserProfile(
                                          null, body, widget.userId);

                              if (updatedProfile != null) {
                                // ignore: use_build_context_synchronously
                                context.push('/flowThree',
                                    extra: {'userId': widget.userId});
                              } else {
                                // ignore: use_build_context_synchronously
                                AppSnackBar.buildSnackbar(
                                    context,
                                    'Không được để trống',
                                    null,
                                    SnackBarType.error);
                              }
                            } else {
                              // ignore: use_build_context_synchronously
                              AppSnackBar.buildSnackbar(
                                  context,
                                  'Không được để trống',
                                  null,
                                  SnackBarType.error);
                            }
                          },
                        ),
                      )
                    ],
                  )),
            ]),
          ),
        ));
  }
}
