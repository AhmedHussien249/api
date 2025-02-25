import 'package:api/core/logic/dio_helper.dart';
import 'package:api/themar_screens/terms/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';

class TermsCubit extends Cubit<TermsStates> {
  final DioHelper _dio;

  TermsCubit(this._dio) : super(TermsLoadingStates());

  Future<void> getData() async {
    final response = await _dio.getData(url: "terms");
    if (response.isSuccess) {
      final list = TermsData.fromJson(response.data).list;
      emit(TermsSuccessStates(list: list));
    } else {
      emit(TermsErrorStates(message: response.message ?? "failed"));
    }
  }
}
