import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/logic/dio_helper.dart';
import 'model.dart';
part 'event.dart';
part 'states.dart';
class CartBloc extends Bloc<CartEvents, CartStates> {
  final DioHelper _dio;
  CartBloc(this._dio) : super(CartLoadingState()) {
on <GetCartEvent>(_getData);
  }

  Future<void> _getData(GetCartEvent event, Emitter<CartStates> emit)async {
    final response = await _dio.getData(url: 'client/cart');
    if (response.isSuccess) {
      final model = CartData.fromJson(response.data);
      emit(CartSuccessState(model: model));
    }else{
      emit(CartErrorState(message: response.message!));
    }
  }
  }

