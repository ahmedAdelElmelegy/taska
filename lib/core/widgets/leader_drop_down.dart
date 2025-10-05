import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/data/model/body/user_model.dart';

class LeaderDropDown extends StatefulWidget {
  final String hint;
  final List<UserModel>? users;
  final void Function(UserModel)? onItemSelected;

  const LeaderDropDown({
    super.key,
    required this.hint,

    this.onItemSelected,
    this.users,
  });

  @override
  State<LeaderDropDown> createState() => _LeaderDropDownstate();
}

class _LeaderDropDownstate extends State<LeaderDropDown> {
  UserModel? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: ColorManager.fill,
      ),
      child: DropdownButtonFormField2<UserModel>(
        value: _selectedItem,
        style: TextStyles.f18Meduim.copyWith(color: ColorManager.grey),
        hint: Text(widget.hint, style: TextStyles.f18Meduim),
        isExpanded: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorManager.fill,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: ColorManager.primary, width: 1.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: ColorManager.primary, width: 2.w),
          ),
        ),
        items:
            widget.users!
                .map(
                  (user) => DropdownMenuItem<UserModel>(
                    value: user,
                    child: Text(user.fullName),
                  ),
                )
                .toList(),
        onChanged: (value) {
          setState(() {
            _selectedItem = value;
          });
          if (widget.onItemSelected != null) {
            widget.onItemSelected!(_selectedItem!);
          }
        },
      ),
    );
  }
}
