part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class CreateOrderEvent extends OrderEvent {
  final int productID;
  final int quantity;
  final int tableID;

  const CreateOrderEvent(
      {required this.productID, required this.quantity, required this.tableID});
}

class GetOrderInTableEvent extends OrderEvent {
  final int tableID;

  const GetOrderInTableEvent({required this.tableID});
}
