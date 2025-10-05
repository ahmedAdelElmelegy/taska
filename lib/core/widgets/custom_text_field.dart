import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final bool? isPassword;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final void Function(String?)? onFieldSubmitted;
  final void Function(String?)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final AutovalidateMode? autovalidateMode;
  final Color? color;
  final Key? formKey;
  final void Function()? onTap;
  final bool? readOnly;
  final bool? obsecure;

  const CustomTextField({
    super.key,
    required this.text,
    this.isPassword,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onSaved,
    this.onFieldSubmitted,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.autovalidateMode,
    this.color,
    this.formKey,
    this.onTap,
    this.readOnly,
    this.obsecure,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly ?? false,
      controller: controller,
      obscureText: obsecure ?? false,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        fillColor: color ?? ColorManager.field,
        filled: true,
        hintText: text,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: outlinBorder(false),
        enabledBorder: outlinBorder(true),
        focusedBorder: outlinBorder(false),
      ),
    );
  }

  OutlineInputBorder outlinBorder(bool enabled) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide:
          enabled
              ? BorderSide.none
              : BorderSide(color: ColorManager.primary, width: 2.w),
    );
  }
}
