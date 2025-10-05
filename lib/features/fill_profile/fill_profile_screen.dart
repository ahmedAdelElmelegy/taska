import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taska/core/helper/app_constants.dart';

import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/helper/validator.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/svg_icon.dart';

import 'package:taska/core/widgets/text_pop.dart';
import 'package:taska/data/bloc/auth/auth_cubit.dart';
import 'package:taska/data/model/body/user_model.dart';
import 'package:taska/features/fill_profile/widgets/profile_image.dart';

class FillProfileScreen extends StatefulWidget {
  final bool isEdit;
  const FillProfileScreen({super.key, this.isEdit = false});

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  TextEditingController dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final cubit = AuthCubit.get(context);
              cubit.fullNameController.text = cubit.user?.fullName ?? '';
              cubit.usernameController.text = cubit.user?.userName ?? '';
              cubit.dateController.text = cubit.user?.dateOfBirth ?? '';
              cubit.email.text =
                  cubit.user?.email ?? cubit.emailController.text;
              cubit.phoneController.text = cubit.user?.phoneNumber ?? '';
              cubit.roleController.text = cubit.user?.role ?? '';
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Form(
                  key: cubit.formkeycreateProfile,
                  child: Column(
                    children: [
                      verticalSpace(41),
                      TextPop(text: 'Fill your profile'),
                      verticalSpace(48),
                      ProfileImage(
                        onImageSelected: (image) {
                          cubit.imageUrl = image;
                        },
                      ),
                      verticalSpace(24),
                      CustomTextField(
                        validator: (p0) => Validator.validateFullName(p0),
                        controller: cubit.fullNameController,
                        text: 'Full Name',
                      ),
                      verticalSpace(24),
                      CustomTextField(
                        validator: (p0) => Validator.validateUsername(p0),
                        controller: cubit.usernameController,

                        text: 'Username',
                      ),
                      verticalSpace(24),
                      CustomTextField(
                        validator: (p0) => Validator.validateDateOfBirth(p0),
                        controller: cubit.dateController,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: DateTime.now(),
                            lastDate: DateTime.now(),
                          ).then((value) {
                            if (value != null) {
                              cubit.dateController.text =
                                  "${value.month}/${value.day}/${value.year}";
                            }
                          });
                        },
                        text: 'Date Of Birth',
                        keyboardType: TextInputType.datetime,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgIcon(icon: AppIcons.calendar2),
                        ),
                      ),
                      verticalSpace(24),
                      CustomTextField(
                        validator: (p0) => Validator.validateEmail(p0),
                        controller: cubit.email,
                        keyboardType: TextInputType.emailAddress,
                        text: 'Email',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgIcon(icon: AppIcons.email2),
                        ),
                      ),
                      verticalSpace(24),
                      CustomTextField(
                        validator: (p0) => Validator.validatePhone(p0),
                        controller: cubit.phoneController,
                        keyboardType: TextInputType.phone,
                        suffixIcon: Icon(Icons.call, color: ColorManager.grey),
                        text: 'Phone Number',
                      ),
                      verticalSpace(24),
                      CustomTextField(
                        validator: (p0) => Validator.role(p0),
                        controller: cubit.roleController,
                        text: 'Role',
                      ),
                      verticalSpace(48),
                      CustomBtn(
                        onPressed: () {
                          if (widget.isEdit) {
                            AuthCubit.get(context).updateProfile(
                              UserModel(
                                uid: cubit.user?.uid ?? '',
                                fullName: cubit.fullNameController.text,
                                userName: cubit.usernameController.text,
                                dateOfBirth: cubit.dateController.text,
                                email: cubit.email.text,
                                phoneNumber: cubit.phoneController.text,
                                role: cubit.roleController.text,
                              ),
                            );
                          } else {
                            if (cubit.imageUrl?.path.isEmpty ?? true) {
                              Fluttertoast.showToast(
                                msg: "Please upload an image!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                            } else if (cubit.formkeycreateProfile.currentState!
                                .validate()) {
                              FirebaseAuth.instance.currentUser?.uid;
                              final uid =
                                  cubit.usersCredential?.user?.uid ?? '';
                              final userModel = UserModel(
                                uid: uid,
                                fullName: cubit.fullNameController.text,
                                userName: cubit.usernameController.text,
                                dateOfBirth: cubit.dateController.text,

                                email: cubit.email.text,
                                phoneNumber: cubit.phoneController.text,
                                role: cubit.roleController.text,
                              );
                              cubit.createUserProfile(
                                userModel,
                                File(cubit.imageUrl!.path),
                              );
                            }
                          }
                        },
                        text: 'Continue',
                        color:
                            state is CreateUserProfileLoading
                                ? ColorManager.primary
                                : ColorManager.secondary,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
