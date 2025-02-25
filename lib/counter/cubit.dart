import 'package:api/core/logic/dio_helper.dart';
import 'package:api/counter/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterUpdateState());
  int counter = 1;

  void minus() {
    counter--;
    emit(CounterUpdateState());
  }

  void plus() {
    counter++;
    emit(CounterUpdateState());
  }
}
