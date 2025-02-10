// products_cubit_state.dart
import '../../../models/products_models.dart';

sealed class ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final ProductsData productsData;

  ProductsLoaded(this.productsData);
}

class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);
}