import 'package:api/core/logic/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models.dart';
import 'states.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  final DioHelper _dio;

  ProductsCubit(this._dio) : super(ProductsLoadingState());

  //late ProductsData model;

  Future<void> getData() async {
    final response = await _dio.getData(url: "products");
    if (response.isSuccess) {
      final list = ProductsData.fromJson(response.data).list;
      emit(ProductsSuccessState(list: list));
    } else {
      emit(ProductsErrorState(message: response.message ?? "failed"));
    }
    //isLoading = false;
    //setState(() {});
  }
}
