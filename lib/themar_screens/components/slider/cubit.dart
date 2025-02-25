import 'package:api/themar_screens/components/slider/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import 'model.dart';

class SliderCubit extends Cubit<SliderStates> {
  final DioHelper _dio ;
  SliderCubit(this._dio) : super(SliderLoadingStates());

  //late SliderData model;
  //late CustomResponse response;
  //int currentIndex = 0;

  Future<void> getData() async {
    final response = await _dio.getData(url: "sliders");
    if (response.isSuccess) {
      final list = SliderData.fromJson(response.data).list;
      emit(SliderSuccessStates(list: list, currentIndex: 0));
    } else {
      emit(SliderErrorStates(message: response.message ?? "failed"));
    }

    // isLoading = false;
    // setState(() {});
  }

  void changeCurrentIndex(int index) {
    if (state is SliderSuccessStates) {
      final currentState = state as SliderSuccessStates;
      emit(SliderSuccessStates(list: currentState.list, currentIndex: index));
    }
  }
}
