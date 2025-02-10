// products_cubit.dart
import 'package:api/products_section2/states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/products_models.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsLoading()) {
    // Immediately fetch data when the cubit is created
    getData();
  }

  Future<void> getData() async {
    try {
      final response =
      await Dio().get("https://thimar.amr.aait-d.com/api/products");
      final model = ProductsData.fromJson(response.data);
      emit(ProductsLoaded(model));
    } catch (e) {
      emit(ProductsError("Failed to load products"));
    }
  }
}