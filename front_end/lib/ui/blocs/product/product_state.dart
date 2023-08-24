part of 'product_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  const ProductState({
    required this.status,
    this.error,
    this.productResponse
  });

  final ProductStatus status;
  final String? error;
  final ProductResponse? productResponse;

  @override
  List<Object?> get props => [status, error, productResponse];

  ProductState copyWith({
    ProductStatus? status,
    String? error,
  }) {
    return ProductState(
      status: status ?? this.status,
      error: error,
    );
  }
}