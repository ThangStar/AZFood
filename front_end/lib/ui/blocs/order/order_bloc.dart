import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/apis/invoice/invoice.api.dart';
import 'package:restaurant_manager_app/apis/order/order.api.dart';
import 'package:restaurant_manager_app/model/invoice.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/ui/screens/bill/pay_success_screen.dart';
import 'package:restaurant_manager_app/utils/io_client.dart';
import 'package:restaurant_manager_app/utils/response.dart';

part 'order_events.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc()
      : super(const OrderState(
          status: OrderStatus.initial,
        )) {
    on<CreateOrderEvent>(_createOrderEvent);
    on<GetOrderInTableEvent>(_getOrderInTableEvent);
    on<PayBillEvent>(_payBillEvent);
  }

  FutureOr<void> _createOrderEvent(
      CreateOrderEvent event, Emitter<OrderState> emit) async {
    LoginResponse? loginResponse = await MySharePreferences.loadProfile();

    if (loginResponse != null) {
      int userID = loginResponse.id;
      Object result = await OrderApi.create(event.product, userID);
      if (result is Success) {
        io.emit("listProductByIdTable", {"id": event.product.tableID});
      } else if (result is Failure) {
        print(result.response);
      }
    }
  }

  FutureOr<void> _getOrderInTableEvent(
      GetOrderInTableEvent event, Emitter<OrderState> emit) async {
    Object result = await OrderApi.getOrderInTable(event.tableID);
    if (result is Success) {
      // print(result.response.data);
    } else if (result is Failure) {
      print("failure ${result.response}");
    }
  }

  FutureOr<void> _payBillEvent(
      PayBillEvent event, Emitter<OrderState> emit) async {
    Object result = await OrderApi.payBill(event.tableId);

    if (result is Success) {
      print("pay success ${result.response}");
      // print();
      LoginResponse? loginResponse = await MySharePreferences.loadProfile();
      BillData billData = BillData(
          idInvoice: result.response.data['invoiceID'],
          sumPrice: 999999,
          username: loginResponse?.username ?? "username",
          time: DateTime.now().toIso8601String());
      io.emit("listProductByIdTable", {"id": event.tableId});
      event.pushScreen(PayStatus.success, billData);
    } else if (result is Failure) {
      print("pay failure ${result.response} ");
      event.pushScreen(PayStatus.failed, null);
    }
  }
}
