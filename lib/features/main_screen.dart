import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/function/app_fun.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/out_line_btn.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/features/chat/chat_screen.dart';
import 'package:taska/features/home/home_screen.dart';
import 'package:taska/features/profile/profile_screen.dart';
import 'package:taska/features/projects/new_project_screen.dart';
import 'package:taska/features/projects/project_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool _showPopup = false;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _togglePopup() {
    setState(() {
      _showPopup = !_showPopup;
    });
  }

  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    ProjectScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_currentIndex],
          if (_showPopup)
            Positioned.fill(
              child: GestureDetector(
                onTap: _togglePopup,
                child: Container(
                  color: Colors.black.withOpacity(0.3), // Dimmed background
                ),
              ),
            ),
          if (_showPopup)
            Positioned(
              bottom: 5.h,
              left: MediaQuery.of(context).size.width / 2 - 80.w,
              child: _popupCard(),
            ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 90.h,
        child: Container(
          color:
              _showPopup
                  ? Colors.black.withOpacity(0.3)
                  : Colors.white, // Dimmed background
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavigationBarItem(
                0,
                () => _onItemTapped(0),
                _currentIndex == 0 ? AppIcons.iconsHomeA : AppIcons.iconsHome,
              ),
              _buildBottomNavigationBarItem(
                1,
                () => _onItemTapped(1),
                _currentIndex == 1
                    ? AppIcons.iconsProjectA
                    : AppIcons.iconsProject,
              ),
              InkWell(
                onTap: () {
                  _togglePopup();
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: ColorManager.primary,
                  child:
                      _showPopup
                          ? Icon(Icons.clear, color: Colors.white)
                          : SvgIcon(
                            icon: AppIcons.iconsAdd,
                            color: Colors.white,
                          ),
                ),
              ),
              _buildBottomNavigationBarItem(
                2,
                () => _onItemTapped(2),
                _currentIndex == 2 ? AppIcons.chatActive : AppIcons.chat,
              ),
              _buildBottomNavigationBarItem(
                3,
                () => _onItemTapped(3),
                _currentIndex == 3
                    ? AppIcons.iconsProfileA
                    : AppIcons.iconsProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBarItem(
    int index,
    Function() onTap,
    String icon,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: SvgIcon(
        icon: icon,
        color:
            index == _currentIndex ? ColorManager.primary : ColorManager.grey,
      ),
    );
  }

  Widget _popupCard() {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 160.w,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _popupItem(
              AppIcons.iconsProject,
              "Project",
              onTap: () {
                _togglePopup();
                defaultBottomSheet(
                  context,
                  title: 'New Project',
                  child: Column(
                    children: [
                      CustomTextField(text: 'Project Name'),
                      verticalSpace(24),
                      CustomTextField(text: 'Visibility'),
                      verticalSpace(24),
                      PrimaryOutLineBtn(text: 'Add', height: 55.h),
                      verticalSpace(18),
                      CustomBtn(
                        text: 'Create Project',
                        onPressed: () {
                          push(NewProjectScreen());
                        },
                        color: ColorManager.secondary,
                      ),
                      verticalSpace(36),
                    ],
                  ),
                );
              },
            ),
            // const Divider(height: 1),
            _popupItem(
              AppIcons.group2,
              "Group",
              onTap: () {
                _togglePopup();
                defaultBottomSheet(
                  context,
                  title: 'New Group Chat',
                  child: Column(
                    children: [
                      CustomTextField(text: 'Group Name'),
                      verticalSpace(24),

                      verticalSpace(24),
                      PrimaryOutLineBtn(text: 'Add', height: 50.h),
                      verticalSpace(18),
                      CustomBtn(
                        text: 'Create Group Chat',
                        onPressed: () {},
                        color: ColorManager.secondary,
                      ),
                      verticalSpace(36),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _popupItem(String icon, String label, {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 12),
            SvgIcon(icon: icon),
          ],
        ),
      ),
    );
  }
}
