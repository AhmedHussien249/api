part of 'bloc.dart';
class UpdateCartItemStates {}

class UpdateCartItemLoadingState extends UpdateCartItemStates {}

class UpdateCartItemSuccessState extends UpdateCartItemStates {}

class UpdateCartItemErrorState extends UpdateCartItemStates {
  final String message;
  UpdateCartItemErrorState({required this.message});
}