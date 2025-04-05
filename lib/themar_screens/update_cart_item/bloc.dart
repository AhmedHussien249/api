import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';
import '../../core/logic/helper.dart';

part 'event.dart';
part 'states.dart';

class UpdateCartItemBloc
    extends Bloc<UpdateCartItemEvents, UpdateCartItemStates> {
  final DioHelper _dio;

  UpdateCartItemBloc(this._dio) : super(UpdateCartItemStates()) {
    on<UpdateCartItemEvent>(_sendData);
  }

  Future<void> _sendData(
      UpdateCartItemEvent event, Emitter<UpdateCartItemStates> emit) async {
    emit(UpdateCartItemLoadingState());
    final response = await _dio.send('client/cart/update/${event.id}',
        data: {"quantity": event.quantity});
    if (response.isSuccess) {
      showMessage("تم التحديث بنجاح");
      emit(UpdateCartItemSuccessState());
    } else {
      emit(UpdateCartItemErrorState(message: response.message!));
    }
  }
}
