import 'dart:io';

import 'package:audiory_v0/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AppImagePicker extends StatefulWidget {
  final double? width;
  final double? height;
  final bool? isRoundShape;
  final String? initialUrl;
  final Function(dynamic) callback;
  const AppImagePicker(
      {super.key,
      this.width = 100,
      this.height = 100,
      required this.callback,
      this.isRoundShape = false,
      this.initialUrl = ""});

  @override
  State<AppImagePicker> createState() => _AppImagePickerState();
}

class _AppImagePickerState extends State<AppImagePicker> {
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final AppColors appColors = Theme.of(context).extension<AppColors>()!;

    bool isRounded = widget.isRoundShape ?? false;

    bool loading = false;

    String initImage = widget.initialUrl ?? '';

    Future pickImageFromGallery() async {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnedImage == null) {
        return;
      }
      setState(() {
        selectedImage = File(returnedImage.path ?? '');
      });

      widget.callback(selectedImage);
    }

    print(initImage);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          selectedImage != null || initImage != ""
              ? GestureDetector(
                  onTap: () {
                    pickImageFromGallery();
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(isRounded == true ? 100 : 0),
                        child: initImage == "" || selectedImage != null
                            ? Image.file(
                                fit: BoxFit.cover,
                                selectedImage ?? File(''),
                                width: widget.width,
                                height:
                                    isRounded ? widget.width : widget.height,
                              )
                            : Image.network(
                                initImage,
                                width: widget.width,
                                fit: BoxFit.cover,
                                height:
                                    isRounded ? widget.width : widget.height,
                              ),
                      ),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {
                              pickImageFromGallery();
                            },
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: appColors.primaryBase,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Icon(
                                Icons.edit,
                                color: appColors.skyLightest,
                              ),
                            ),
                          ))
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    pickImageFromGallery();
                  },
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(isRounded == true ? 100 : 8),
                      child: Container(
                        width: widget.width,
                        height: isRounded ? widget.width : widget.height,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(
                                isRounded == true ? 100 : 8),
                            border: Border.all(
                                color: appColors.inkLighter,
                                style: BorderStyle.solid,
                                width: 0.5)),
                      ),
                    ),
                    Positioned(
                        child: Icon(
                      Icons.image,
                      color: appColors.inkLight,
                    ))
                  ]),
                ),
        ],
      ),
    );
  }
}
