part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthFaiure extends AuthState {}

final class CreateUserProfileSuccess extends AuthState {}

final class CreateUserProfileFailure extends AuthState {}

final class CreateUserProfileLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFailure extends AuthState {}

final class LoginLoading extends AuthState {}

final class LogoutLoading extends AuthState {}

final class LogoutSuccess extends AuthState {}

final class LogoutFailure extends AuthState {}

final class GetuserProfileLoading extends AuthState {}

final class GetuserProfileSuccess extends AuthState {}

final class GetuserProfileFailure extends AuthState {
  final String message;

  GetuserProfileFailure(this.message);
}

final class GetCurrentUserLoading extends AuthState {}

final class GetCurrentUserSuccess extends AuthState {}

final class GetCurrentUserFailure extends AuthState {}

final class UpdateProfileLoading extends AuthState {}

final class UpdateProfileSuccess extends AuthState {}

final class UpdateProfileFailure extends AuthState {}

final class ToggleObsecure extends AuthState {}
