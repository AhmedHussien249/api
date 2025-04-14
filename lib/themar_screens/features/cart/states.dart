part of 'bloc.dart';
class CartStates{}
class CartLoadingState extends CartStates{}
class CartSuccessState extends CartStates{
  final CartData model;
  CartSuccessState({required this.model});
}
class CartErrorState extends CartStates{
  final String message;
  CartErrorState({required this.message});
}