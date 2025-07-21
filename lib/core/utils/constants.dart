import 'package:taska/core/helper/app_constants.dart';

import 'package:taska/data/body/on_boarding_model.dart';
import 'package:taska/data/body/profile_model.dart';
import 'package:taska/data/body/sub_task_model.dart';
import 'package:taska/features/fill_profile/widgets/profile_image.dart';

class Constants {
  static List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      image: AppImages.on1,
      title: 'Organize Your Tasks & Projects Easily',
      description:
          'With decades of maintenance of way expertise and experience, no one knows the rail like Loram. Today, we’re leveraging our ',
    ),
    OnBoardingModel(
      image: AppImages.on2,
      title: 'Always Connect with Team Anytime Anywhere',
      description:
          'With decades of maintenance of way expertise and experience, no one knows the rail like Loram. Today, we’re leveraging our ',
    ),
    OnBoardingModel(
      image: AppImages.on3,
      title: 'Evereything You Can Do in the App',
      description:
          'With decades of maintenance of way expertise and experience, no one knows the rail like Loram. Today, we’re leveraging our ',
    ),
  ];
  static List<SubTaskModel> subTaskList = [
    SubTaskModel(title: 'Team', icon: AppIcons.team),
    SubTaskModel(title: 'Leader', icon: AppIcons.person),
    SubTaskModel(title: 'Status', icon: AppIcons.iconsCheck),
    SubTaskModel(title: 'Due Date', icon: AppIcons.calender),
    SubTaskModel(title: 'Attachment', icon: AppIcons.due),
  ];
  static List<String> status = ["To-Do", 'In-Progress', 'Pending', 'Completed'];
  static List<SubTaskModel> attachment = [
    SubTaskModel(title: 'Document', icon: AppIcons.folder),
    SubTaskModel(title: 'Camera', icon: AppIcons.camera),
    SubTaskModel(title: 'Gallery', icon: AppIcons.gallery),
  ];
  static List<SubTaskModel> cover = [
    SubTaskModel(title: 'Camera', icon: AppIcons.camera),
    SubTaskModel(title: 'Gallery', icon: AppIcons.gallery),
  ];
  static List<ProfileModel> profileItem = [
    ProfileModel(title: 'Workspace', icon: AppIcons.work),
    ProfileModel(title: 'Edit Profile', icon: AppIcons.user),
    ProfileModel(title: 'Notifications', icon: AppIcons.iconsNotification),
    ProfileModel(title: 'Security', icon: AppIcons.security),
    ProfileModel(title: 'Help', icon: AppIcons.help),
    ProfileModel(icon: AppIcons.logout, title: 'Logout'),
  ];
}
