part of 'product_size_bloc.dart';

enum ProductSizeStateStatus { initial, loading, success, failure }

class ProductSizeState extends Equatable {
  final List<ProductPriceSize> productSize;

  ProductSizeState({this.productSize = const []});

  @override
  // TODO: implement props
  List<Object?> get props => [productSize];

  ProductSizeState copyWith({
    List<ProductPriceSize>? productSize,
  }) {
    return ProductSizeState(
      productSize: productSize ?? this.productSize,
    );
  }
}
