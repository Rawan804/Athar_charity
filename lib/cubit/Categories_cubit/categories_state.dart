
part of 'categories_cubit.dart';

abstract class CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<Project> projects;
  CategoriesSuccess(this.projects);
}

class CategoriesFailure extends CategoriesState {
  final String message;
  CategoriesFailure(this.message);
}

class CategoriesSelected extends CategoriesState {
  final Project project;
  CategoriesSelected(this.project);
}
