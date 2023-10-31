import 'dart:async';
import 'dart:convert';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/apis/product/product.api.dart';
import 'package:restaurant_manager_app/model/category_response.dart';
import 'package:restaurant_manager_app/model/product.dart';
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
    on<GetProductFilterEvent>(_getProductFilterEvent);
    on<GetListProductByIdTable>(_getListProductByIdTable);
    on<GetListProductStatusEvent>(_getListProductStatusEvent);
    on<SearchProductEvent>(_searchProductEvent);
    on<ChangePageProductEvent>(_changePageProductEvent);
    on<DecreaseProductQuantity>(_decreaseProductQuantity);
  }

  FutureOr<void> _getProductsEvent(
      GetProductsEvent event, Emitter<ProductState> emit) async {
    final data = await getProduct(state.page);
    print("data, $data");
    ProductResponse productResponse = ProductResponse.fromJson(data);
    emit(state.copyWith(
        productResponse: productResponse,
        total: data['totalItems'],
        totalPage: data['totalPages'],
        page: data['currentPage']));
  }

  Future<dynamic> getProduct(int page) async {
    Object result = await ProductApi.getProduct(page);
    ProductResponse? productResponse;
    if (result is Success) {
      return result.response.data;
    } else if (result is Failure) {
      print("failure ${result.response}");
      return null;
    }
  }

  FutureOr<void> _getCategoryEvent(
      GetCategoryEvent event, Emitter<ProductState> emit) async {
    Object result = await ProductApi.getCategory();
    if (result is Success) {
      CategoryResponse categoryResponse =
          CategoryResponse.fromJson(jsonDecode(result.response.toString()));
      emit(state.copyWith(categoryResponse: categoryResponse));
      // print("Success ${result.response}");
    } else if (result is Failure) {
      print("failure ${result.response}");
    }
  }

  FutureOr<void> _getProductFilterEvent(
      GetProductFilterEvent event, Emitter<ProductState> emit) async {
    print('productsFilter, id cate ${event.idCategory}');
    Object result = await ProductApi.productsFilter(event.idCategory);
    if (result is Success) {
      print('productsFilter ${result.response}');
      List<dynamic> jsonProducts =
          result.response.data["data"] as List<dynamic>;
      emit(state.copyWith(
          productResponse: ProductResponse(
        data: jsonProducts.map((e) => Product.fromJson(e)).toList(),
        // currentPage: 1,
        // totalPages: 0,
        // totalItems: 0
      )));
    } else if (result is Failure) {}
  }

  FutureOr<void> _getListProductByIdTable(
      GetListProductByIdTable event, Emitter<ProductState> emit) async {
    await Future.delayed(600.ms);

    emit(state.copyWith(
        currentProducts: event.currentProducts, status: ProductStatus.success));
  }

  FutureOr<void> _getListProductStatusEvent(
      GetListProductStatusEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: event.status));
  }

  FutureOr<void> _searchProductEvent(
      SearchProductEvent event, Emitter<ProductState> emit) async {
    Object result = await ProductApi.search(event.query);
    if (result is Success) {
      print(result.response.data);
      List<dynamic> jsonList = result.response.data['data'] as List<dynamic>;
      emit(state.copyWith(
          productsSearchResults:
              jsonList.map((e) => Product.fromJson(e)).toList()));
    } else if (result is Failure) {
      emit(state.copyWith(productsSearchResults: []));
    }
  }

  FutureOr<void> _changePageProductEvent(
      ChangePageProductEvent event, Emitter<ProductState> emit) async {
    final data =
        await getProduct(event.isNext ? state.page + 1 : state.page - 1);
    ProductResponse productResponse = ProductResponse.fromJson(data);
    emit(state.copyWith(
        productResponse: productResponse,
        total: data['totalItems'],
        totalPage: data['totalPages'],
        page: data['currentPage']));
  }

  FutureOr<void> _decreaseProductQuantity(
      DecreaseProductQuantity event, Emitter<ProductState> emit) {

  }
}
