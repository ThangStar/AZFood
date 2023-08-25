// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  const ProductState(
      {this.status, this.error, this.productResponse, this.categoryResponse, this.productsFilter});

  final ProductStatus? status;
  final String? error;
  final ProductResponse? productResponse;
  final CategoryResponse? categoryResponse;
  final List<Product>? productsFilter;

  @override
  List<Object?> get props =>
      [status, error, productResponse, categoryResponse, productsFilter];

  ProductState copyWith({
    ProductStatus? status,
    String? error,
    ProductResponse? productResponse,
    CategoryResponse? categoryResponse,
    List<Product>? productsFilter,
  }) {
    return ProductState(
      status: status ?? this.status,
      error: error ?? this.error,
      productResponse: productResponse ?? this.productResponse,
      categoryResponse: categoryResponse ?? this.categoryResponse,
      productsFilter: productsFilter ?? this.productsFilter,
    );
  }
}
