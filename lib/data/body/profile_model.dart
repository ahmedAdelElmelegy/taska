import 'package:flutter/animation.dart';

class ProfileModel {
  final String icon;
  final String title;
  final VoidCallback? onTap;

  ProfileModel({required this.icon, required this.title, this.onTap});
}
