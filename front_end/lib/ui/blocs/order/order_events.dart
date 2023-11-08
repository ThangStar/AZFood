part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class ProductCheckOut {
  final int productID;
  final int quantity;
  final int tableID;

  ProductCheckOut(
      {required this.productID, required this.quantity, required this.tableID});
}

class CreateOrderEvent extends OrderEvent {
  final ProductCheckOut product;

  const CreateOrderEvent({required this.product});
}

class GetOrderInTableEvent extends OrderEvent {
  final int tableID;

  const GetOrderInTableEvent({required this.tableID});
}

class PayBillEvent extends OrderEvent {
  final int tableId;
  final Function(PayStatus, BillData?) pushScreen;

  PayBillEvent({required this.tableId, required this.pushScreen});
}

class OnIncrementProduct extends OrderEvent{

}