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

class GetCategoryEvent extends ProductEvent {
  @override
  // TODO: implement props
  List<Object> get props => super.props;
}

class GetProductFilterEvent extends ProductEvent {
  final int idCategory;

  const GetProductFilterEvent({required this.idCategory});
}
