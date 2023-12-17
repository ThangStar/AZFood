import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/apis/product/product.api.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/ui/blocs/order/order_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/product/add_product_to_current_booking_screen.dart';
import 'package:restaurant_manager_app/ui/utils/my_alert.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';
import 'package:restaurant_manager_app/ui/widgets/item_product.dart';
import 'package:restaurant_manager_app/utils/response.dart';

import '../blocs/product/product_bloc.dart';

class MySeartDelegate extends SearchDelegate {
  GlobalKey cartKey = GlobalKey();
  final int tableID;
  List<Product> productsSelected;

  MySeartDelegate(
      {super.searchFieldLabel,
      super.searchFieldStyle,
      super.searchFieldDecorationTheme,
      super.keyboardType,
      super.textInputAction,
      required this.productsSelected,
      required this.tableID});

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
                  onTap: () {
                    if (product.price == 0) {
                      myAlert(
                              context,
                              checkDeviceType(
                                  MediaQuery.of(context).size.width),
                              AlertType.error,
                              "Cảnh báo",
                              "Hãy chọn loại sản phẩm")
                          .show(context);
                      return;
                    }
                    context.read<OrderBloc>().add(CreateOrderEvent(
                        idSize: product.idSizeCurrent,
                        price: product.price,
                        product: ProductCheckOut(
                            productID: product.id,
                            quantity: 1,
                            tableID: tableID)));
                    final index = productsSelected.indexWhere(
                      (element) => element.id == product.id,
                    );

                    myAlert(
                            context,
                            checkDeviceType(MediaQuery.of(context).size.width),
                            AlertType.success,
                            "Thành công",
                            "Order thành công")
                        .show(context);
                    return;
                  },
                  cartKey: cartKey,
                  isAddCart: product.price != 0,
                  product: product,
                  subTitle: SubTitleProduct(product: product),
                  trailling: SubTitleItemCurrentBill(product: product));
            },
          );
        }
        return Text("Không tìm thấy sản phầm nào");
      },
    );
  }
}
