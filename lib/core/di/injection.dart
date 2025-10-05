import 'package:get_it/get_it.dart';
import 'package:taska/core/services/firebase_services.dart';
import 'package:taska/core/services/group_services.dart';
import 'package:taska/core/services/project_services.dart';
import 'package:taska/data/bloc/auth/auth_cubit.dart';
import 'package:taska/data/bloc/group/group_cubit.dart';
import 'package:taska/data/bloc/project/project_cubit.dart';
import 'package:taska/data/repo/auth_repo.dart';
import 'package:taska/data/repo/group_repo.dart';
import 'package:taska/data/repo/project_repo.dart';

final getIt = GetIt.instance;
void init() {
  getIt.registerLazySingleton<FirebaseServices>(() => FirebaseServices());
  // for repositories
  getIt.registerFactory<AuthRepo>(() => AuthRepo(getIt<FirebaseServices>()));
  // for cubits
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));
  getIt.registerLazySingleton(
    () => ProjectServices(),
  ); // Ensure FirebaseServices is registered
  getIt.registerLazySingleton(() => ProjectRepo(getIt<ProjectServices>()));
  getIt.registerLazySingleton(() => GroupServices());
  getIt.registerFactory<ProjectCubit>(() => ProjectCubit(getIt<ProjectRepo>()));
  getIt.registerLazySingleton(() => GroupRepo(getIt<GroupServices>()));
  getIt.registerFactory<GroupCubit>(() => GroupCubit(getIt<GroupRepo>()));
}
