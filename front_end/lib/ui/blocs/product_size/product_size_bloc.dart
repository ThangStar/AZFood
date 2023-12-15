import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/apis/product/product.api.dart';
import 'package:restaurant_manager_app/model/ProductPriceSize.dart';
import 'package:restaurant_manager_app/utils/response.dart';

part 'product_size_event.dart';

part 'product_size_state.dart';

class ProductSizeBloc extends Bloc<ProductSizeEvent, ProductSizeState> {
  ProductSizeBloc() : super(ProductSizeState()) {
    on<GetAllSizePrdEvent>(_getAllSizePrdEvent);
  }

  FutureOr<void> _getAllSizePrdEvent(
      GetAllSizePrdEvent event, Emitter<ProductSizeState> emit) async {
    Object result = await ProductApi.getSizePrice();
    if (result is Success) {
      print('success${result.response.data}');
      List<dynamic> jsonPrds =
          result.response.data['resultRaw'] as List<dynamic>;
      List<ProductPriceSize> priceSizes =
          jsonPrds.map((e) => ProductPriceSize.fromJson(e)).toList();
      emit(state.copyWith(productSize: priceSizes));
    } else if (result is Failure) {
      print("failure ${result.response}");
    }
  }
}
