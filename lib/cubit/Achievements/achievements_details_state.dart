part of 'achievements_details_cubit.dart';

 class AchievementsDetailsState {}

final class AchievementsDetailsLoading extends AchievementsDetailsState {}
final class AchievementsDetailsSuccess extends AchievementsDetailsState {
   final AchievementsDetailsModel achievementsDetailsModel;
   AchievementsDetailsSuccess(this.achievementsDetailsModel);
}
final class AchievementsDetailsFail extends AchievementsDetailsState {}

