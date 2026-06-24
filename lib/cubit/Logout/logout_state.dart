part of 'logout_cubit.dart';

@immutable
sealed class LogoutState {}

final class LogoutLoading extends LogoutState {}
final class LogoutSuccess extends LogoutState {}
final class LogoutFail extends LogoutState {}