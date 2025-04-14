part of 'bloc.dart';
class UpdateCartItemStates {}

class UpdateCartItemLoadingState extends UpdateCartItemStates {}

class UpdateCartItemSuccessState extends UpdateCartItemStates {
  final int id;
  final bool isAdd;
  UpdateCartItemSuccessState({required this.id, required this.isAdd});
}

class UpdateCartItemErrorState extends UpdateCartItemStates {
  final String message;
  UpdateCartItemErrorState({required this.message});
}