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
  final int price;
  final int? idSize;

  const CreateOrderEvent({required this.product, required this.price, required this.idSize});
}

class GetOrderInTableEvent extends OrderEvent {
  final int tableID;

  const GetOrderInTableEvent({required this.tableID});
}

class PayBillEvent extends OrderEvent {
  final int tableId;
  final int payMethod;
  final Function(PayStatus, BillData?) pushScreen;

  const PayBillEvent(
      {required this.tableId,
      required this.pushScreen,
      required this.payMethod});
}

class OnUpdateProductQuantity extends OrderEvent {
  final int productID, tableID;
  final int? quantity;
  final TypeUpdateQuantity type;
  final int? idOrderItems;

  const OnUpdateProductQuantity(
      {required this.productID,
      required this.tableID,
      this.quantity,
      this.idOrderItems,
      required this.type});
}
