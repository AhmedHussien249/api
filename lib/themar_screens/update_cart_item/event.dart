part of 'bloc.dart';
class UpdateCartItemEvents {}

class UpdateCartItemEvent extends UpdateCartItemEvents {
  final int id;
  final num quantity;
  UpdateCartItemEvent({required this.id, required this.quantity});
}