import 'package:api/themar_screens/components/category_section/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import 'models.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() : super(CategoriesLoadingState());

  // late bool isLoading = true;
  //late CustomResponse response;

  Future<void> getData() async {
    final response = await DioHelper.getData(url: "categories");
    if (response.isSuccess) {
      final list = CategoriesData.fromJson(response.data).list;
      emit(CategoriesSuccessState(list: list));
    } else {
      emit(CategoriesErrorState(message: response.message ?? "failed"));
    }
    // isLoading = false;
    // setState(() {});
  }
}
