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
      this.page = 1,
        this.totalPage = 5,
      this.total = 5,
      this.currentProducts});

  final ProductStatus? status;
  final String? error;
  final ProductResponse? productResponse;
  final CategoryResponse? categoryResponse;
  final List<Product>? productsFilter;
  final List<Product>? currentProducts;
  final List<Product>? productsSearchResults;
  final int page;
  final int total;
  final int totalPage;

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
    int? page,
    int? total,
    int? totalPage,
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
      page: page ?? this.page,
      total: total ?? this.total,
      totalPage: totalPage ?? this.totalPage,
    );
  }
}

class CurrentProductLoading extends ProductState {}

class PlusProducts extends ProductState {}
class MinusProducts extends ProductState {}


class CurrentProductSuccess extends ProductState {
  @override
  final List<Product>? currentProducts;

  const CurrentProductSuccess({this.currentProducts});
}
