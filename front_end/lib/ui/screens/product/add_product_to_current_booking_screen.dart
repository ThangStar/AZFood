import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/model/product_booking.dart';
import 'package:restaurant_manager_app/model/product_response.dart';
import 'package:restaurant_manager_app/ui/blocs/product/product_bloc.dart';
import 'package:restaurant_manager_app/ui/widgets/item_product.dart';
import 'package:restaurant_manager_app/ui/widgets/leading_item_status.dart';
import 'package:restaurant_manager_app/ui/widgets/my_icon_button.dart';
import 'package:restaurant_manager_app/ui/widgets/my_icon_button_blur.dart';
import 'package:restaurant_manager_app/ui/widgets/page_index.dart';

class AddProductToCurrentBookingScreen extends StatefulWidget {
  const AddProductToCurrentBookingScreen({super.key});

  @override
  State<AddProductToCurrentBookingScreen> createState() =>
      _AddProductToCurrentBookingScreenState();
}

class _AddProductToCurrentBookingScreenState
    extends State<AddProductToCurrentBookingScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = BlocProvider.of(context);
    productBloc.add(const GetProductsEvent());
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(2),
                child: Divider(thickness: 2)),
            title: const Text(
              "Mặt hàng",
              style: TextStyle(fontSize: 24),
            ),
            actions: [
              MyIconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              const SizedBox(
                width: 16,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: PageIndex(),
                ),
                TabBar(
                    controller: TabController(length: 4, vsync: this),
                    tabs: const [
                      Tab(
                        text: "Tất cả",
                      ),
                      Tab(
                        text: "Đồ ăn",
                      ),
                      Tab(
                        text: "Đồ uống",
                      ),
                      Tab(
                        text: "Khác",
                      )
                    ]),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state.productResponse != null) {
                      return ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            Product product = state.productResponse!.data[index];
                            return ItemProduct(
                                product: product,
                                subTitle: Text("${product.quantity}"),
                                trailling: SubTitleItemCurrentBill(product: product));
                          });
                    }
                    return const Text("Xảy ra lỗi khi lấy dữ liệu");
                  },
                )
              ],
            ),
          )),
    );
  }
}
