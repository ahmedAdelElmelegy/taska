import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taska/core/helper/app_constants.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/core/helper/spacing.dart';
import 'package:taska/core/helper/validator.dart';
import 'package:taska/core/themes/colors.dart';
import 'package:taska/core/widgets/custom_btn.dart';
import 'package:taska/core/widgets/custom_text_field.dart';
import 'package:taska/core/widgets/out_line_btn.dart';
import 'package:taska/core/widgets/svg_icon.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/model/body/project_model.dart';
import 'package:taska/features/projects/widgets/member_number.dart';
import 'package:taska/features/teams/add_team.dart';
import 'package:uuid/uuid.dart';

class ProjectForm extends StatefulWidget {
  const ProjectForm({super.key});

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProjectCubit>();
    return BlocBuilder<ProjectCubit, ProjectState>(
      builder: (context, state) {
        if (state is CreateProjectLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CreateProjectFailure) {
          return Center(child: Text(state.message));
        }
        return Form(
          key: cubit.formKey,
          child: Column(
            children: [
              CustomTextField(
                validator: (value) => Validator.validateFullName(value),
                controller: cubit.nameController,

                text: 'Project Name',
              ),
              verticalSpace(24),

              // CustomDropDown(
              //   hint: 'Visibility',
              //   items: ['Public', 'Private'],
              //   onItemSelected: (p0) {
              //     cubit.visibility = p0 ?? 'Public';
              //   },
              // ),
              verticalSpace(24),
              cubit.members.isNotEmpty
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MemberNumber(memberCount: cubit.members.length),

                      GestureDetector(
                        onTap: () {
                          push(AddTeam());
                        },
                        child: SvgIcon(icon: AppIcons.addRounded),
                      ),
                    ],
                  )
                  : PrimaryOutLineBtn(
                    onPressed: () {
                      push(AddTeam());
                    },
                    text: 'Add',
                    height: 55.h,
                  ),
              verticalSpace(18),
              CustomBtn(
                text: 'Create Project',
                onPressed: () {
                  final ownerId = FirebaseAuth.instance.currentUser?.uid ?? '';
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.createProject(
                      projectModel: ProjectModel(
                        memberIds: [ownerId, ...cubit.membersIds],
                        id: Uuid().v4(),
                        name: cubit.nameController.text,
                        visibility: cubit.visibility,
                        members: cubit.members,
                        ownerId: ownerId,
                        createdAt: DateTime.now(),
                      ),
                    );
                  }
                  cubit.getProjects();
                },
                color:
                    cubit is CreateProjectLoading
                        ? ColorManager.primary
                        : ColorManager.secondary,
              ),
              verticalSpace(36),
            ],
          ),
        );
      },
    );
  }
}
