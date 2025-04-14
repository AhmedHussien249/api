import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper.dart';


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

    final response = await _dio.send('client/cart/${event.id}',
        data: {"amount": event.isAdd==true? event.amount + 1 : event.amount-1, "_method": "PUT"});
    print(event.id);
    print("amount:${ event.isAdd==true? event.amount + 1 : event.amount-1}");
    if (response.isSuccess) {
      showMessage("تم التحديث بنجاح");
      emit(UpdateCartItemSuccessState(id: event.id, isAdd: event.isAdd));
    } else {
      emit(UpdateCartItemErrorState(message: response.message!));
    }
  }
}
