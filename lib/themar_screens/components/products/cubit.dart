import 'package:api/core/logic/dio_helper.dart';
import 'package:api/themar_screens/components/products/models.dart';
import 'package:api/themar_screens/components/products/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsStates> {
  ProductsCubit() : super(ProductsLoadingState());

  //late ProductsData model;

  Future<void> getData() async {
    final response = await DioHelper.getData(url: "products");
    if (response.isSuccess) {
      final list = ProductsData.fromJson(response.data).list;
      emit(ProductsSuccessState(list: list));
    } else {
      emit(ProductsErrorState());
    }
    //isLoading = false;
    //setState(() {});
  }
}
