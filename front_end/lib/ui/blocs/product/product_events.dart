part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductsEvent extends ProductEvent {
  final int page;

  const GetProductsEvent({this.page = 1});

  @override
  // TODO: implement props
  List<Object> get props => [page];
}

class GetCategoryEvent extends ProductEvent {}

class GetProductFilterEvent extends ProductEvent {
  final int idCategory;

  const GetProductFilterEvent({required this.idCategory});
}

class GetListProductByIdTable extends ProductEvent {
  final List<Product>? currentProducts;

  const GetListProductByIdTable({required this.currentProducts});
}

class GetListProductStatusEvent extends ProductEvent {
  final ProductStatus status;

  const GetListProductStatusEvent({required this.status});
}

class SearchProductEvent extends ProductEvent {
  final String query;

  const SearchProductEvent({required this.query});
}

class ChangePageProductEvent extends ProductEvent {
  final bool isNext;

  const ChangePageProductEvent({this.isNext = true});
}

class DecreaseProductQuantity extends ProductEvent {
  final int idProduct;

  const DecreaseProductQuantity(this.idProduct);
}

class OnChangeTableId extends ProductEvent {
  final int id;

  const OnChangeTableId({required this.id});
}

class OnChangeSizeTransformPrice extends ProductEvent {
  final int idSize;
  final int productId;

  const OnChangeSizeTransformPrice({required this.idSize, required this.productId});
}
