import 'models.dart';

class CategoriesStates {}

class CategoriesSuccessState extends CategoriesStates {
  final List<CategoryModel> list;

  CategoriesSuccessState({required this.list});
}

class CategoriesErrorState extends CategoriesStates {
  final String message;

  CategoriesErrorState({required this.message});
}

class CategoriesLoadingState extends CategoriesStates {}
