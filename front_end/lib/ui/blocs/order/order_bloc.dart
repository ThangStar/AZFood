import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/apis/order/order.api.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
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
  }

  FutureOr<void> _createOrderEvent(
      CreateOrderEvent event, Emitter<OrderState> emit) async {
    LoginResponse? loginResponse = await MySharePreferences.loadProfile();

    if (loginResponse != null) {
      int userID = loginResponse.id;
      Object result = await OrderApi.create(
          event.productID, event.quantity, userID, event.tableID);
      if (result is Success) {
        print(result.response.data);
      } else if (result is Failure) {
        print(result.response);
      }
    }
  }

  FutureOr<void> _getOrderInTableEvent(
      GetOrderInTableEvent event, Emitter<OrderState> emit) async {
    Object result = await OrderApi.getOrderInTable(event.tableID);
    if (result is Success) {
      print(result.response.data);
    } else if (result is Failure) {
      print(result.response);
    }
  }
}
