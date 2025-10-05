import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taska/core/function/app_fun.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/model/body/user_model.dart';

class ProfileImage extends StatefulWidget {
  final UserModel? user;
  final bool isEdit;
  final void Function(XFile)? onImageSelected;
  const ProfileImage({
    super.key,
    this.user,
    this.isEdit = false,
    this.onImageSelected,
  });

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  XFile? selectedImage;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        selectedImage != null
            ? Container(
              height: 140.r,
              width: 140.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: FileImage(File(selectedImage!.path)),
                  fit: BoxFit.cover,
                ),
              ),
            )
            : CircleAvatar(
              radius: 70.r,
              child:
                  widget.user?.imageUrl != null
                      ? Container(
                        height: 140.r,
                        width: 140.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(widget.user!.imageUrl!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      : Icon(
                        Icons.person,
                        size: 70.r,
                        color: ColorManager.grey,
                      ),
            ),
        CircleAvatar(
          radius: 20.r,
          backgroundColor: ColorManager.primary,
          child: IconButton(
            icon: SvgIcon(icon: AppIcons.edit, color: ColorManager.white),
            onPressed: () {
              defaultBottomSheet(
                context,
                title: 'Add Image',
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectImage(ImageSource.camera);
                            pop();
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40.r,
                                backgroundColor: ColorManager.primaryDark,
                                child: SvgIcon(
                                  icon: AppIcons.camera,
                                  color: ColorManager.primary,
                                  width: 30.w,
                                  height: 30.h,
                                ),
                              ),
                              verticalSpace(16),
                              Text(
                                'Camera',
                                style: TextStyles.f16SemiBoldBlack,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            selectImage(ImageSource.gallery);
                            pop();
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40.r,
                                backgroundColor: ColorManager.primaryDark,
                                child: SvgIcon(
                                  icon: AppIcons.gallery,
                                  color: ColorManager.primary,
                                  width: 30.w,
                                  height: 30.h,
                                ),
                              ),
                              verticalSpace(16),
                              Text(
                                'Gallery',
                                style: TextStyles.f16SemiBoldBlack,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(36),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future selectImage(ImageSource source) async {
    var image = await ImagePicker().pickImage(source: source);
    setState(() {
      selectedImage = image;
      widget.onImageSelected?.call(image!);
    });
  }
}
