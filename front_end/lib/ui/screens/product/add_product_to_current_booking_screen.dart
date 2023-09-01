import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/ui/blocs/product/product_bloc.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/item_product.dart';
import 'package:restaurant_manager_app/ui/widgets/my_icon_button.dart';
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
  List<Product> productsSelected = [];
  late AnimationController moveController;
  late Animation moveAnimation;

  GlobalKey cartKey = GlobalKey();

  bool isShowCart = false;
  @override
  void initState() {
    super.initState();
    moveController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));

    moveAnimation =
        CurvedAnimation(parent: moveController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    moveController.dispose();
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
            floatingActionButton: FloatingActionButton.extended(
              key: cartKey,
                isExtended: false,
                backgroundColor: colorScheme(context).primary,
                onPressed: () {},
                label: const Text(
                  "Xác nhận thêm",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.done,
                  color: Colors.white,
                )),
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
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state.productResponse != null) {
                        return ListView.builder(
                            itemCount:
                                state.productResponse!.data.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              Product product =
                                  state.productResponse!.data[index];
                              return ItemProduct(
                                  cartKey: cartKey,
                                  product: product,
                                  onTap: () {
                                    productsSelected = [
                                      ...productsSelected,
                                      product
                                    ];
                                  },
                                  subTitle:
                                      SubTitleProduct(product: product),
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
