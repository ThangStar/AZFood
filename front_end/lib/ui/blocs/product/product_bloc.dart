import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/apis/product/product.api.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:restaurant_manager_app/model/product_response.dart';
import 'package:restaurant_manager_app/utils/response.dart';

part 'product_events.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc()
      : super(const ProductState(
          status: ProductStatus.initial,
        )) {
    on<GetProductsEvent>(_getProductsEvent);
  }

  FutureOr<void> _getProductsEvent(
      GetProductsEvent event, Emitter<ProductState> emit) async {
    Object result = await ProductApi.getProduct(event.page);
    if (result is Success) {
      ProductResponse productResponse =
          ProductResponse.fromJson(jsonDecode(result.response.toString()));
          emit(ProductState(status: ProductStatus.success, productResponse: productResponse));
      print("Success ${result.response}");
    } else if (result is Failure) {
      print("failure ${result.response}");
    }
  }
}
