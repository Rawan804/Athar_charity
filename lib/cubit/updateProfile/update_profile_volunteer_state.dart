part of 'update_profile_volunteer_cubit.dart';

@immutable
sealed class UpdateProfileVolunteerState {}

final class UpdateProfileVolunteerLoading extends UpdateProfileVolunteerState {}
final class UpdateProfileVolunteerSuccesses extends UpdateProfileVolunteerState {}
final class UpdateProfileVolunteerFail extends UpdateProfileVolunteerState {}