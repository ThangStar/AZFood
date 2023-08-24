import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    productBloc.add(GetCategoryEvent());

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(5.seconds);
        },
        child: Scaffold(
            appBar: AppBar(
              bottom: const PreferredSize(
                  preferredSize: Size.zero,
                  child: Divider(
                    height: 1,
                  )),
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
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: PageIndex(),
                  ),
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state.categoryResponse != null) {
                        return TabBar(
                            onTap: (value) {
                              if (value != 0) {
                                print(state.categoryResponse!
                                    .category[value - 1].name);
                                    //get product follow category
                              }
                            },
                            controller: TabController(
                                length:
                                    state.categoryResponse!.category.length + 1,
                                vsync: this),
                            tabs: [
                              const Tab(
                                text: "Tất cả",
                              ),
                              ...state.categoryResponse!.category
                                  .map((e) => Tab(
                                        text: e.name,
                                      ))
                                  .toList()
                            ]);
                      }
                      return const Text("Không tìm thấy danh mục nào");
                    },
                  ),
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state.productResponse != null) {
                        return ListView.builder(
                            itemCount: state.productResponse!.data.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              Product product =
                                  state.productResponse!.data[index];
                              return ItemProduct(
                                  product: product,
                                  subTitle: Text("${product.quantity}"),
                                  trailling: SubTitleItemCurrentBill(
                                      product: product));
                            });
                      }
                      return const Text("Xảy ra lỗi khi lấy dữ liệu");
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
