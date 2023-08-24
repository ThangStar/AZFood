import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/apis/product/product.api.dart';
import 'package:restaurant_manager_app/model/category_response.dart';
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
    on<GetCategoryEvent>(_getCategoryEvent);
  }

  FutureOr<void> _getProductsEvent(
      GetProductsEvent event, Emitter<ProductState> emit) async {
    Object result = await ProductApi.getProduct(event.page);
    if (result is Success) {
      ProductResponse productResponse =
          ProductResponse.fromJson(jsonDecode(result.response.toString()));
      emit(state.copyWith(
        productResponse: productResponse
      ));
      print("Success ${result.response}");
    } else if (result is Failure) {
      print("failure ${result.response}");
    }
  }

  FutureOr<void> _getCategoryEvent(
      GetCategoryEvent event, Emitter<ProductState> emit) async {
    Object result = await ProductApi.getCategory();
    if (result is Success) {
      CategoryResponse categoryResponse =
          CategoryResponse.fromJson(jsonDecode(result.response.toString()));
      emit(state.copyWith(
          categoryResponse: categoryResponse));
      print("Success ${result.response}");
    } else if (result is Failure) {
      print("failure ${result.response}");
    }
  }
}
