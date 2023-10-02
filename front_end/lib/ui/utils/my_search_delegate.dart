import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/apis/product/product.api.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/ui/widgets/item_product.dart';
import 'package:restaurant_manager_app/utils/response.dart';

import '../blocs/product/product_bloc.dart';

class MySeartDelegate extends SearchDelegate {
  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle => TextStyle(fontSize: 24);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {},
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return FlutterLogo(
      size: 22,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    context.read<ProductBloc>().add(SearchProductEvent(query: query));
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.productsSearchResults?.length != 0) {
          return ListView.builder(
            itemCount: state.productsSearchResults?.length,
            itemBuilder: (BuildContext context, int index) {
              Product product = state.productsSearchResults![index];
              return ItemProduct(
                  isAddCart: true,
                  product: product,
                  subTitle: Text("${product.price}"),
                  trailling: FlutterLogo());
            },
          );
        }
        return Text("Không tìm thấy sản phầm nào");
      },
    );
  }
}
