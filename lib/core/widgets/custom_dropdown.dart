import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';

class CustomDropDown extends StatefulWidget {
  final String hint;
  const CustomDropDown({super.key, required this.hint});
  static List<String> leaders = ['Ahmed', 'Mohamed', 'Ali'];

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? _selectedItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: ColorManager.fill,
      ),
      child: DropdownButtonFormField2(
        value: _selectedItem,
        style: TextStyles.f16Medium.copyWith(color: ColorManager.grey),
        hint: Text(widget.hint, style: TextStyles.f16Regular),
        isExpanded: true,
        decoration: InputDecoration(border: InputBorder.none),
        items:
            CustomDropDown.leaders
                .map(
                  (item) =>
                      DropdownMenuItem<String>(value: item, child: Text(item)),
                )
                .toList(),
        onChanged: (value) {
          setState(() {
            _selectedItem = value;
          });
        },
      ),
    );
  }
}
