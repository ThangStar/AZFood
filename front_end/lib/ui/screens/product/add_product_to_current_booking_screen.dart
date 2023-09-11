import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/ui/blocs/order/order_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/product/product_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/checkout/check_out_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/item_product.dart';
import 'package:restaurant_manager_app/ui/widgets/my_icon_button.dart';
import 'package:restaurant_manager_app/ui/widgets/page_index.dart';

class AddProductToCurrentBookingScreen extends StatefulWidget {
  const AddProductToCurrentBookingScreen({super.key, required this.tableID});
  final int tableID;

  @override
  State<AddProductToCurrentBookingScreen> createState() =>
      _AddProductToCurrentBookingScreenState();
}

class _AddProductToCurrentBookingScreenState
    extends State<AddProductToCurrentBookingScreen>
    with TickerProviderStateMixin {
  List<Product> productsSelected = [];

  late AnimationController moveCartController;

  GlobalKey cartKey = GlobalKey();
  bool isExtended = false;

  @override
  void initState() {
    super.initState();
    moveCartController = AnimationController(vsync: this, duration: 1.seconds);
    moveCartController.addListener(() {
      if (moveCartController.isCompleted) {
        setState(() {
          isExtended = true;
        });
      }
    });
  }

  @override
  void dispose() {
    moveCartController.dispose();
    super.dispose();
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
            floatingActionButton: SlideTransition(
              position: moveCartController.drive(
                  Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)),
              child: FloatingActionButton.extended(
                  heroTag: "check_out",
                  key: cartKey,
                  backgroundColor: colorScheme(context).primary,
                  onPressed: () {
                    setState(() {
                      isExtended = !isExtended;
                    });
                  },
                  label: AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) =>
                            FadeTransition(
                      opacity: animation,
                      child: SizeTransition(
                        child: child,
                        sizeFactor: animation,
                        axis: Axis.horizontal,
                      ),
                    ),
                    child: !isExtended
                        ? const Icon(Icons.shopping_cart_rounded)
                        : const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 4.0),
                                child: Icon(Icons.add),
                              ),
                              Text("Đã thêm")
                            ],
                          ),
                  )),
            ),
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
            body: Column(
              children: [
                SingleChildScrollView(
                    child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: PageIndex(),
                  ),
                  BlocBuilder<ProductBloc, ProductState>(
                    buildWhen: (previous, current) =>
                        previous.categoryResponse != current.categoryResponse,
                    builder: (context, state) {
                      if (state.categoryResponse != null) {
                        return TabBar(
                            onTap: (value) {
                              if (value != 0) {
                                context.read<ProductBloc>().add(
                                    GetProductFilterEvent(
                                        idCategory: state.categoryResponse!
                                            .category[value - 1].id));
                              } else {
                                productBloc.add(const GetProductsEvent());
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
                                  isAddCart: true,
                                  cartKey: cartKey,
                                  product: product,
                                  onTap: () {
                                    moveCartController.forward();
                                    context.read<OrderBloc>().add(
                                            CreateOrderEvent(products: [
                                          ProductCheckOut(
                                              productID: product.id,
                                              quantity: 1,
                                              tableID: widget.tableID)
                                        ]));
                                    // final index = productsSelected.indexWhere(
                                    //   (element) => element.id == product.id,
                                    // );
                                    // if (index == -1) {
                                    //   setState(() {
                                    //     productsSelected = [
                                    //       ...productsSelected,
                                    //       product
                                    //     ];
                                    //   });
                                    // } else {
                                    //   // List<Product>  newData = List.from(productsSelected);
                                    //   // newData[index].quantity! = 1;
                                    //   Product productUpdate =
                                    //       productsSelected[index];
                                    //   if (productUpdate.quantity != null) {
                                    //     ++productUpdate.amountCart;
                                    //   }
                                    //   setState(() {
                                    //     productsSelected[index] = productUpdate;
                                    //   });
                                    // }
                                  },
                                  subTitle: SubTitleProduct(product: product),
                                  trailling: SubTitleItemCurrentBill(
                                      product: product));
                            });
                      }
                      return const Text("Xảy ra lỗi khi lấy dữ liệu");
                    },
                  ),
                ])),
              ],
            ),
          )),
    );
  }
}

class SubTitleProduct extends StatelessWidget {
  const SubTitleProduct({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    int quantity = product.quantity ?? 0;
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: quantity != 0 ? const Color(0xFF049C6B) : null,
            ),
            padding: quantity != 0
                ? const EdgeInsets.symmetric(horizontal: 14, vertical: 4)
                : null,
            child: Row(
              children: [
                quantity != 0
                    ? const SizedBox.shrink()
                    : const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                Text(
                  quantity != 0 && product.category != 1
                      ? "Kho: $quantity"
                      : quantity == 0
                          ? " Hết hàng "
                          : "Sẵn sàng",
                  style: TextStyle(
                      color: quantity != 0 ? Colors.white : Colors.red),
                ),
              ],
            )),
      ],
    );
  }
}
