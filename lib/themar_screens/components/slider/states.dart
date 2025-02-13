import 'model.dart';

class SliderStates {}

class SliderLoadingStates extends SliderStates {}

class SliderSuccessStates extends SliderStates {
  final List<SlidersModel> list;
  final int currentIndex;

  SliderSuccessStates({required this.list, required this.currentIndex});
}

class SliderErrorStates extends SliderStates {
  final String message;

  SliderErrorStates({required this.message});
}
