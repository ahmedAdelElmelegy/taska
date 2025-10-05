import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/text_pop.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';

class SetColor extends StatefulWidget {
  final String projectId;
  const SetColor({super.key, required this.projectId});

  @override
  State<SetColor> createState() => _SetColorState();
}

class _SetColorState extends State<SetColor> {
  Color selectedColor = ColorManager.primary;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                verticalSpace(40),
                TextPop(text: 'Set Color'),
                verticalSpace(24),
                GridViewColor(
                  onTap: (color) {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                ),
                verticalSpace(24),
                CustomBtn(
                  onPressed: () {
                    context.read<ProjectCubit>().updateProjectColor(
                      widget.projectId,
                      selectedColor,
                    );
                  },
                  text: 'Set Color',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GridViewColor extends StatefulWidget {
  final void Function(Color color)? onTap;
  const GridViewColor({super.key, this.onTap});

  @override
  State<GridViewColor> createState() => _GridViewColorState();
}

class _GridViewColorState extends State<GridViewColor> {
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ColorManager.colors.length + 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) {
        if (index == ColorManager.colors.length) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: 121.w,
              height: 124.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(width: 1, color: ColorManager.lightGrey),
              ),
              child: Icon(Icons.add, color: ColorManager.grey),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onTap!(ColorManager.colors[index]);
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: 121.w,
                  height: 124.h,

                  decoration: BoxDecoration(
                    color: ColorManager.colors[index],
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
                _selectedIndex == index
                    ? Positioned(
                      top: 10,
                      right: 10,
                      child: Icon(Icons.check, color: Colors.white),
                    )
                    : Container(),
              ],
            ),
          );
        }
      },
    );
  }
}
