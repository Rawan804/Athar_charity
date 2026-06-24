part of 'achievements_cubit.dart';


 class AchievementsState {}

 class AchievementsLoading extends AchievementsState {}
class AchievementsSuccess extends AchievementsState {
  final List<Achievements>achievements;
  AchievementsSuccess(this.achievements);
}
class AchievementsFailure extends AchievementsState  {
  final String message;
  AchievementsFailure(this.message);
}
class AchievementSelected extends AchievementsState{
   final Achievements achievements;
   AchievementSelected(this.achievements);
}
