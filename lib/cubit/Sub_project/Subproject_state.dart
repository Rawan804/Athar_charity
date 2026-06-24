part of 'Subproject_cubit.dart';

 abstract class SubprojectState {}

class SubprojectLoading extends SubprojectState {}

class SubprojectSuccess extends SubprojectState {
  final List<Subprojectmodel> project;
  SubprojectSuccess(this.project);
}

class SubprojectFailed extends SubprojectState {
 final String message;
 SubprojectFailed(this.message);
}
class Subproject_Selected extends SubprojectState {
  final Subprojectmodel selectedProject;
  Subproject_Selected(this.selectedProject);
}


