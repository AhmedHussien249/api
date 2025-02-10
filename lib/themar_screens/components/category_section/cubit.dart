import 'package:api/themar_screens/components/category_section/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import 'models.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit(): super(CategoriesLoadingState());

  // late bool isLoading = true;
  late CategoriesData model;
  late CustomResponse response;

  Future<void> getData() async {
    response = await DioHelper.getData(url: "categories");
    if (response.isSuccess) {
      model = CategoriesData.fromJson(response.data);
      emit(CategoriesSuccessState());
    }else{
      emit(CategoriesErrorState());
    }
   // isLoading = false;
   // setState(() {});
  }

}