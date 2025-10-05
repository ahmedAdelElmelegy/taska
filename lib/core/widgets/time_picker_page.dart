import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/helper/extentions.dart';

class HourPickerPage extends StatefulWidget {
  final void Function(TimeOfDay)? onHourSelected;

  const HourPickerPage({super.key, this.onHourSelected});

  @override
  State<HourPickerPage> createState() => _HourPickerPageState();
}

class _HourPickerPageState extends State<HourPickerPage> {
  int? selectedHour;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: const Color(0xFFF6FAFD),
      ),
      padding: EdgeInsets.all(16.w),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 24,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 2,
        ),
        itemBuilder: (context, index) {
          final hour = index;
          final isSelected = selectedHour == hour;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedHour = hour;
              });
              if (widget.onHourSelected != null) {
                widget.onHourSelected!(TimeOfDay(hour: hour, minute: 0));
              }
              pop(); // Close the sheet
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF4C82F6) : Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color:
                      isSelected
                          ? const Color(0xFF4C82F6)
                          : Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "${hour.toString().padLeft(2, '0')}:00",
                style:
                    isSelected
                        ? TextStyles.f16SemiBoldBlack.copyWith(
                          color: Colors.white,
                        )
                        : TextStyles.f16Regular.copyWith(color: Colors.black87),
              ),
            ),
          );
        },
      ),
    );
  }
}
