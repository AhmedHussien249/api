import 'package:api/core/logic/dio_helper.dart';
import 'package:api/themar_screens/terms/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';

class TermsCubit extends Cubit<TermsStates> {
  TermsCubit() : super(TermsLoadingStates());

  Future<void> getData() async {
    final response = await DioHelper.getData(url: "terms");
    if (response.isSuccess) {
      final list = TermsData.fromJson(response.data).list;
      emit(TermsSuccessStates(list: list));
    } else {
      emit(TermsErrorStates(message: response.message ?? "failed"));
    }
  }
}
