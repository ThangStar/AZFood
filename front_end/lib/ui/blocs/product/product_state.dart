// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  const ProductState(
      {this.status,
      this.error,
      this.productResponse,
      this.categoryResponse,
      this.productsFilter,
      this.productsSearchResults,
      this.currentProducts});

  final ProductStatus? status;
  final String? error;
  final ProductResponse? productResponse;
  final CategoryResponse? categoryResponse;
  final List<Product>? productsFilter;
  final List<Product>? currentProducts;
  final List<Product>? productsSearchResults;

  @override
  List<Object?> get props => [
        status,
        error,
        productResponse,
        categoryResponse,
        productsFilter,
        currentProducts,
        productsSearchResults
      ];

  ProductState copyWith({
    ProductStatus? status,
    String? error,
    ProductResponse? productResponse,
    CategoryResponse? categoryResponse,
    List<Product>? productsFilter,
    List<Product>? currentProducts,
    List<Product>? productsSearchResults,
  }) {
    return ProductState(
      status: status ?? this.status,
      error: error ?? this.error,
      productResponse: productResponse ?? this.productResponse,
      categoryResponse: categoryResponse ?? this.categoryResponse,
      productsFilter: productsFilter ?? this.productsFilter,
      currentProducts: currentProducts ?? this.currentProducts,
      productsSearchResults:
          productsSearchResults ?? this.productsSearchResults,
    );
  }
}

class CurrentProductLoading extends ProductState {}

class CurrentProductSuccess extends ProductState {
  @override
  final List<Product>? currentProducts;

  const CurrentProductSuccess({this.currentProducts});
}
