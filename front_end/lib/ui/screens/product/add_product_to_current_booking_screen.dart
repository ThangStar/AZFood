import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/ui/blocs/order/order_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/product/product_bloc.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/my_search_delegate.dart';
import 'package:restaurant_manager_app/ui/widgets/item_product.dart';
import 'package:restaurant_manager_app/ui/widgets/keyboard_icon.dart';
import 'package:restaurant_manager_app/ui/widgets/my_icon_button.dart';
import 'package:restaurant_manager_app/ui/widgets/page_index.dart';

import '../../utils/size_config.dart';

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

  GlobalKey cartKey = GlobalKey();
  late ProductBloc productBloc;

  @override
  void initState() {
    productBloc = BlocProvider.of(context);
    productBloc.add(const GetProductsEvent());
    productBloc.add(GetCategoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(5.seconds);
          },
          child: CallbackShortcuts(
            bindings: <ShortcutActivator, VoidCallback>{
              const SingleActivator(LogicalKeyboardKey.keyK, control: true):
                  () {
                showSearch(context: context, delegate: MySeartDelegate());
              },
              const SingleActivator(LogicalKeyboardKey.escape): () {
                Navigator.pop(context);
              },
            },
            child: FocusScope(
              autofocus: true,
              child: Scaffold(
                backgroundColor: colorScheme(context).background,
                floatingActionButton: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      state.page != 1
                          ? FloatingActionButton.extended(
                              backgroundColor: colorScheme(context).error,
                              onPressed: () {
                                productBloc
                                    .add(ChangePageProductEvent(isNext: false));
                              },
                              label: Icon(
                                Icons.arrow_back,
                                color: colorScheme(context).onPrimary,
                              ),
                            )
                          : const SizedBox.shrink(),
                      state.page < state.totalPage
                          ? FloatingActionButton.extended(
                              heroTag: "check_out",
                              key: cartKey,
                              backgroundColor: colorScheme(context).secondary,
                              onPressed: () {
                                productBloc.add(ChangePageProductEvent());
                              },
                              label: Icon(
                                Icons.arrow_forward,
                                color: colorScheme(context).onPrimary,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  );
                }),
                appBar: AppBar(
                  shadowColor: colorScheme(context).background,
                  surfaceTintColor: colorScheme(context).background,
                  backgroundColor: colorScheme(context).onPrimary,
                  elevation: 4,
                  bottom: PreferredSize(
                      preferredSize: Size.zero,
                      child: Divider(
                        color: colorScheme(context).scrim.withOpacity(0.4),
                        height: 2,
                      )),
                  title: const Text(
                    "Mặt hàng",
                    style: TextStyle(fontSize: 24),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () => showSearch(
                          context: context, delegate: MySeartDelegate()),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  colorScheme(context).scrim.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(24),
                          color: colorScheme(context).tertiary.withOpacity(0.4),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 22,
                            ),
                            Text(
                              " Tìm kiếm...  ",
                              style: TextStyle(fontSize: 14),
                            ),
                            KeyBoardIcon(
                              label: "ctrl",
                            ),
                            KeyBoardIcon(
                              label: "k ",
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
                body: RawKeyboardListener(
                  focusNode: FocusNode(),
                  onKey: (value) {
                    print(value.logicalKey);
                    if (value is RawKeyDownEvent) {
                      if (value.logicalKey == LogicalKeyboardKey.keyK) {
                        print("object");
                        showSearch(
                            context: context, delegate: MySeartDelegate());
                      }
                    }
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: PageIndex(),
                        ),
                        BlocBuilder<ProductBloc, ProductState>(
                          buildWhen: (previous, current) =>
                              previous.categoryResponse !=
                              current.categoryResponse,
                          builder: (context, state) {
                            if (state.categoryResponse != null) {
                              return TabBar(
                                  onTap: (value) {
                                    if (value != 0) {
                                      context.read<ProductBloc>().add(
                                          GetProductFilterEvent(
                                              idCategory: state
                                                  .categoryResponse!
                                                  .category[value - 1]
                                                  .id));
                                    } else {
                                      productBloc.add(const GetProductsEvent());
                                    }
                                  },
                                  controller: TabController(
                                      length: state.categoryResponse!.category
                                              .length +
                                          1,
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
                        LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              if (state.productResponse != null) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: GridView.builder(
                                      itemCount:
                                          state.productResponse?.data.length,
                                      shrinkWrap: true,
                                      primary: false,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: checkDevice(
                                                  constraints.maxWidth,
                                                  1,
                                                  2,
                                                  3),
                                              mainAxisExtent: 70),
                                      itemBuilder: (context, index) {
                                        Product product =
                                            state.productResponse!.data[index];
                                        return ItemProduct(
                                            isAddCart: true,
                                            cartKey: cartKey,
                                            product: product,
                                            onTap: () {
                                              context.read<OrderBloc>().add(
                                                  CreateOrderEvent(
                                                      product: ProductCheckOut(
                                                          productID: product.id,
                                                          quantity: 1,
                                                          tableID:
                                                              widget.tableID)));
                                              final index =
                                                  productsSelected.indexWhere(
                                                (element) =>
                                                    element.id == product.id,
                                              );
                                              if (index == -1) {
                                                setState(() {
                                                  productsSelected.add(product);
                                                });
                                              }
                                            },
                                            subTitle: SubTitleProduct(
                                                product: product),
                                            trailling: SubTitleItemCurrentBill(
                                                product: product));
                                      }),
                                );
                              }
                              return const Text("Xảy ra lỗi khi lấy dữ liệu");
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
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
              color: (product.quantity != 0 && product.quantity != null) || (product.category == 1 && product.status == 1) ? const Color(0xFF049C6B) : null,
            ),
            padding: (product.quantity != 0 && product.quantity != null) || (product.category == 1 && product.status == 1)
                ? const EdgeInsets.symmetric(horizontal: 14, vertical: 4)
                : null,
            child: Row(
              children: [
                (product.quantity != 0 && product.quantity != null) || (product.category == 1 && product.status == 1)
                    ? const SizedBox.shrink()
                    : const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                Text(
                  quantity != 0 && product.category != 1
                      ? "Kho: $quantity"
                      : product.status == 2 || (quantity == 0 && product.category != 1)
                          ? " Hết hàng "
                          : "Sẵn sàng",
                  style: TextStyle(
                      color: (product.quantity != 0 && product.quantity != null) || (product.category == 1 && product.status == 1) ? Colors.white : Colors.red),
                ),
              ],
            )),
      ],
    );
  }
}
