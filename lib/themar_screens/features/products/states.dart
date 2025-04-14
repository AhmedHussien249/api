import 'models.dart';

class ProductsStates {}

class ProductsLoadingState extends ProductsStates {}

class ProductsErrorState extends ProductsStates {
  final String message;

  ProductsErrorState({required this.message});
}

class ProductsSuccessState extends ProductsStates {
  final List<ProductsModels> list;

  ProductsSuccessState({required this.list});
}
