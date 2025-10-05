import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taska/core/di/injection.dart';
import 'package:taska/data/bloc/auth/auth_cubit.dart';
import 'package:taska/data/bloc/group/group_cubit.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';

class GenerateMultipleBloc extends StatelessWidget {
  final Widget child;
  const GenerateMultipleBloc({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<ProjectCubit>()..getProjects()),
        BlocProvider(create: (_) => getIt<GroupCubit>()),
      ],
      child: child,
    );
  }
}
