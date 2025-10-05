import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/themes/style.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/bloc/auth/auth_cubit.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/features/home/widgets/home_task_item.dart';
import 'package:taska/features/home/widgets/project_item.dart';
import 'package:taska/features/home/widgets/recent_project.dart';
import 'package:taska/features/home/widgets/row_of_home.dart';
import 'package:taska/features/home/widgets/today_task.dart';
import 'package:taska/features/notification/notification_screen.dart';
import 'package:taska/features/projects/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final projectCubit = context.read<ProjectCubit>();
    projectCubit.getTodayTasks();
    projectCubit.getProjects();
    AuthCubit.get(context).fetchUsersProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (context, state) {
          final projectCubit = context.read<ProjectCubit>();
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    verticalSpace(40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              AppImages.logo2,
                              height: 33.h,
                              width: 33.w,
                            ),
                            horizontalSpace(18),
                            Text('Taska', style: TextStyles.f20SemiBold),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => push(NotificationScreen()),
                          child: SvgIcon(
                            icon: AppIcons.iconsNotification,
                            color: ColorManager.primary,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(24),
                    CustomTextField(
                      readOnly: true,
                      onTap: () {
                        push(SearchScreen());
                      },
                      text: 'Search',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.search, color: ColorManager.grey),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgIcon(
                          icon: AppIcons.iconsFilter,

                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                    verticalSpace(24),
                    RowOfHome(
                      text: 'Recent Project',
                      onPress: () {
                        push(RecentProject());
                      },
                    ),
                    verticalSpace(24),
                    state is GetProjectsLoading
                        ? Center(child: CircularProgressIndicator())
                        : SizedBox(
                          height:
                              projectCubit.allProjects
                                      .where(
                                        (element) => element.coverImage != null,
                                      )
                                      .isNotEmpty
                                  ? 350.h
                                  : 200.h,
                          child: Swiper(
                            autoplay: true,
                            itemCount: projectCubit.allProjects.length,
                            itemBuilder:
                                (context, index) => ProjectItem(
                                  isImageView: true,
                                  project: projectCubit.allProjects[index],
                                ),

                            scale: .9,
                            viewportFraction: .87,
                          ),
                        ),
                    verticalSpace(24),
                    RowOfHome(
                      text: 'Today Task',
                      onPress: () {
                        push(TodayTask(projectCubit: projectCubit));
                      },
                    ),
                    verticalSpace(24),
                    state is GetTodayTasksLoading
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: projectCubit.todayTasks.length,
                          itemBuilder: (context, index) {
                            return HomeTaskItem(
                              taskModel: projectCubit.todayTasks[index],
                            );
                          },
                        ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
