import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taska/core/helper/extentions.dart';
import 'package:taska/data/model/body/user_model.dart';
import 'package:taska/data/repo/auth_repo.dart';
import 'package:taska/features/fill_profile/fill_profile_screen.dart';
import 'package:taska/features/login/login_screen.dart';
import 'package:taska/features/main_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formkeycreateProfile = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController roleController = TextEditingController();
  UserCredential? usersCredential;

  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  final formKeyLogin = GlobalKey<FormState>();
  TextEditingController userProfileEmailController = TextEditingController();

  void signUp(String email, String password) async {
    emit(AuthLoading());

    final result = await authRepo.signUp(email: email, password: password);
    result.fold(
      (failure) {
        Fluttertoast.showToast(
          msg: "Sign up failed: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        emit(AuthFaiure());
      },
      (userCredential) {
        usersCredential = userCredential;

        email = email;

        passwordController.clear();
        dateController.clear();
        phoneController.clear();
        roleController.clear();
        imageUrl = XFile('');
        fullNameController.clear();
        usernameController.clear();
        push(FillProfileScreen(isEdit: false));
        Fluttertoast.showToast(
          msg: "Sign up successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        emit(AuthSuccess());
      },
    );
  }

  void login(String email, String password) async {
    emit(LoginLoading());

    final result = await authRepo.login(email: email, password: password);
    result.fold(
      (failure) {
        Fluttertoast.showToast(
          msg: "Login failed: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        emit(LoginFailure());
      },
      (userCredential) {
        usersCredential = userCredential;
        Fluttertoast.showToast(
          msg: "Login successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        loginEmail.clear();
        loginPassword.clear();
        pushAndRemoveUntil(MainScreen());
        emit(LoginSuccess());
      },
    );
  }

  List<UserModel> userProfiles = [];

  void fetchUsersProfile() async {
    emit(GetuserProfileLoading());

    final result = await authRepo.getUsersProfile();
    result.fold(
      (failure) {
        Fluttertoast.showToast(
          msg: "Failed to fetch user profiles: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        emit(GetuserProfileFailure(failure.message));
      },
      (users) {
        userProfiles =
            users
                .where(
                  (element) =>
                      element.uid != FirebaseAuth.instance.currentUser!.uid,
                )
                .toList();

        emit(GetuserProfileSuccess());
      },
    );
  }

  XFile? imageUrl;
  void createUserProfile(UserModel userModel, File image) async {
    emit(AuthLoading());

    final resultImage = await authRepo.uploadImage(image);
    resultImage.fold(
      (failure) {
        emit(UpdateProfileFailure());
      },
      (sucess) async {
        final user = userModel.copyWith(imageUrl: sucess);

        final result = await authRepo.createUserProfile(userModel: user);

        result.fold(
          (failure) {
            Fluttertoast.showToast(
              msg: "Profile creation failed: ${failure.message}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            emit(UpdateProfileFailure());
          },
          (sucess) {
            emit(AuthSuccess());
            emailController.clear();
            passwordController.clear();
            fullNameController.clear();
            usernameController.clear();
            dateController.clear();
            phoneController.clear();
            roleController.clear();
            dateController.text = '';
            imageUrl = XFile('');

            pushReplacement(LoginScreen());
          },
        );
      },
    );
  }

  void logout() async {
    emit(LogoutLoading());
    final result = await authRepo.logout();
    result.fold(
      (failure) {
        Fluttertoast.showToast(
          msg: "Logout failed: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        emit(LogoutFailure());
      },
      (_) {
        Fluttertoast.showToast(
          msg: "Logout successful!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        emit(LogoutSuccess());

        pushAndRemoveUntil(LoginScreen());
      },
    );
    //  pushReplacement(LoginScreen());
  }

  // get cureent user
  UserModel? user;
  Future<void> getCurrentUser() async {
    emit(GetCurrentUserLoading());
    final result = await authRepo.getCurrentUser();
    result.fold(
      (failure) {
        Fluttertoast.showToast(
          msg: "Failed to fetch user profile: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        emit(GetCurrentUserFailure());
      },
      (user) {
        this.user = user;
        emit(GetCurrentUserSuccess());
      },
    );
  }

  // update profile
  void updateProfile(UserModel userModel) async {
    emit(UpdateProfileLoading());
    final result = await authRepo.updateProfile(userModel: userModel);
    result.fold(
      (failure) {
        Fluttertoast.showToast(
          msg: "Failed to update user profile: ${failure.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );

        emit(UpdateProfileFailure());
      },
      (_) {
        Fluttertoast.showToast(
          msg: "User profile updated successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        getCurrentUser();
        push(MainScreen());
        emit(UpdateProfileSuccess());
      },
    );
  }

  // obsecure
  bool obsecure = true;
  void toggleObsecure() {
    obsecure = !obsecure;
    emit(ToggleObsecure());
  }
}
