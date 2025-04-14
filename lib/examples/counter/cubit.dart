import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

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
