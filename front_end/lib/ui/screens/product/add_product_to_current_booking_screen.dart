import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/model/ProductPriceSize.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/ui/blocs/order/order_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/product/product_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/product_size/product_size_bloc.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/my_alert.dart';
import 'package:restaurant_manager_app/ui/utils/my_search_delegate.dart';
import 'package:restaurant_manager_app/ui/widgets/item_product.dart';
import 'package:restaurant_manager_app/ui/widgets/keyboard_icon.dart';
import 'package:restaurant_manager_app/ui/widgets/my_icon_button.dart';
import 'package:restaurant_manager_app/ui/widgets/page_index.dart';
import 'package:restaurant_manager_app/utils/io_client.dart';

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
  late ProductSizeBloc prdSizeBloc;

  @override
  void initState() {
    productBloc = BlocProvider.of(context);
    prdSizeBloc = BlocProvider.of<ProductSizeBloc>(context);
    productBloc.add(const GetProductsEvent());
    productBloc.add(GetCategoryEvent());
    prdSizeBloc.add(GetAllSizePrdEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        productBloc.add(
            const GetListProductStatusEvent(status: ProductStatus.loading));
        io.emit('listProductByIdTable', {"id": widget.tableID});
        if (!io.hasListeners("responseOrder")) {
          io.on('responseOrder', (data) {
            productBloc.add(OnChangeTableId(id: data['tableID'] ?? 0));
            final jsonResponse = data['order'] as List<dynamic>;
            List<Product> currentProducts =
                jsonResponse.map((e) => Product.fromJson(e)).toList();
            productBloc
                .add(GetListProductByIdTable(currentProducts: currentProducts));
          });
        }

        return await true;
      },
      child: SafeArea(
        child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(5.seconds);
            },
            child: CallbackShortcuts(
              bindings: <ShortcutActivator, VoidCallback>{
                const SingleActivator(LogicalKeyboardKey.keyK, control: true):
                    () {
                  showSearch(
                      context: context,
                      delegate: MySeartDelegate(
                          productsSelected: productsSelected,
                          tableID: widget.tableID));
                },
                const SingleActivator(LogicalKeyboardKey.escape): () {
                  Navigator.pop(context);
                },
              },
              child: FocusScope(
                autofocus: true,
                child: Stack(
                  children: [
                    Scaffold(
                      backgroundColor: colorScheme(context).background,
                      floatingActionButton:
                          BlocBuilder<ProductBloc, ProductState>(
                              builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            state.page != 1
                                ? FloatingActionButton.extended(
                                    backgroundColor: colorScheme(context).error,
                                    onPressed: () {
                                      productBloc.add(
                                          const ChangePageProductEvent(
                                              isNext: false));
                                    },
                                    label: Icon(
                                      Icons.arrow_back,
                                      color: colorScheme(context).onPrimary,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            state.page < state.totalPage
                                ? FloatingActionButton.extended(
                                    backgroundColor:
                                        colorScheme(context).secondary,
                                    onPressed: () {
                                      productBloc
                                          .add(const ChangePageProductEvent());
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
                              color:
                                  colorScheme(context).scrim.withOpacity(0.4),
                              height: 2,
                            )),
                        title: const Text(
                          "Mặt hàng",
                          style: TextStyle(fontSize: 24),
                        ),
                        actions: [
                          GestureDetector(
                            onTap: () => showSearch(
                                context: context,
                                delegate: MySeartDelegate(
                                    productsSelected: productsSelected,
                                    tableID: widget.tableID)),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: colorScheme(context)
                                        .scrim
                                        .withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(24),
                                color: colorScheme(context)
                                    .tertiary
                                    .withOpacity(0.4),
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
                                  context: context,
                                  delegate: MySeartDelegate(
                                      productsSelected: productsSelected,
                                      tableID: widget.tableID));
                            }
                          }
                        },
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: BlocBuilder<ProductBloc, ProductState>(
                                  builder: (context, state) {
                                    return PageIndex(
                                      currentPage: state.page,
                                    );
                                  },
                                ),
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
                                            productBloc
                                                .add(const GetProductsEvent());
                                          }
                                        },
                                        controller: TabController(
                                            length: state.categoryResponse!
                                                    .category.length +
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
                                  return const CircularProgressIndicator();
                                },
                              ),
                              LayoutBuilder(builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return BlocBuilder<ProductBloc, ProductState>(
                                  builder: (context, state) {
                                    if (state.productResponse != null) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: GridView.builder(
                                            itemCount: state
                                                .productResponse?.data.length,
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
                                              Product product = state
                                                  .productResponse!.data[index];
                                              return ItemProduct(
                                                  isAddCart: product.price != 0,
                                                  cartKey: cartKey,
                                                  product: product,
                                                  onTap: () {
                                                    if (product.price == 0) {
                                                      myAlert(
                                                              context,
                                                              checkDeviceType(
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width),
                                                              AlertType.error,
                                                              "Cảnh báo",
                                                              "Hãy chọn loại sản phẩm")
                                                          .show(context);
                                                      return;
                                                    }
                                                    context
                                                        .read<OrderBloc>()
                                                        .add(CreateOrderEvent(
                                                            idSize: product
                                                                .idSizeCurrent,
                                                            price:
                                                                product.price,
                                                            product: ProductCheckOut(
                                                                productID:
                                                                    product.id,
                                                                quantity: 1,
                                                                tableID: widget
                                                                    .tableID)));
                                                    final index =
                                                        productsSelected
                                                            .indexWhere(
                                                      (element) =>
                                                          element.id ==
                                                          product.id,
                                                    );
                                                    if (index == -1) {
                                                      setState(() {
                                                        productsSelected
                                                            .add(product);
                                                      });
                                                    }
                                                  },
                                                  subTitle: SubTitleProduct(
                                                      product: product),
                                                  trailling:
                                                      SubTitleItemCurrentBill(
                                                          product: product));
                                            }),
                                      );
                                    }
                                    return const Text(
                                        "Xảy ra lỗi khi lấy dữ liệu");
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 120,
                        right: 20,
                        child: Badge(
                          label: BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              return Text("${state.currentProducts!.length}");
                            },
                          ),
                          child: FloatingActionButton(
                            heroTag: "check_out",
                            key: cartKey,
                            backgroundColor: Colors.deepPurpleAccent,
                            child: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        )),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class SubTitleProduct extends StatefulWidget {
  SubTitleProduct({super.key, required this.product});

  Product product;

  @override
  State<SubTitleProduct> createState() => _SubTitleProductState();
}

class _SubTitleProductState extends State<SubTitleProduct> {
  int idSelected = 0;
  late ProductSizeBloc prdSizeBloc;

  late ProductBloc productBloc;

  @override
  void initState() {
    prdSizeBloc = BlocProvider.of<ProductSizeBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
    print("INIT CALLLLLLL: ${widget.product.id}");
    prdSizeBloc.state.productSize.forEach((element) {
      // print("ID PRODUCT ${widget.product.id} SIZE STORE ${element.productId}");
    });

    List<ProductPriceSize> prd = prdSizeBloc.state.productSize
        .where((element) => element.productId == widget.product.id)
        .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int quantity = widget.product.quantity ?? 0;
    return Row(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: (widget.product.quantity != 0 &&
                          widget.product.quantity != null) ||
                      (widget.product.category == 1 &&
                          widget.product.status == 1)
                  ? const Color(0xFF049C6B)
                  : null,
            ),
            padding: (widget.product.quantity != 0 &&
                        widget.product.quantity != null) ||
                    (widget.product.category == 1 && widget.product.status == 1)
                ? const EdgeInsets.symmetric(horizontal: 14, vertical: 4)
                : null,
            child: Row(
              children: [
                (widget.product.quantity != 0 &&
                            widget.product.quantity != null) ||
                        (widget.product.category == 1 &&
                            widget.product.status == 1)
                    ? const SizedBox.shrink()
                    : const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                Text(
                  quantity != 0 && widget.product.category != 1
                      ? "Kho: $quantity"
                      : widget.product.status == 2 || widget.product.status == null ||
                              (quantity == 0 && widget.product.category != 1)
                          ? " Hết hàng "
                          : "Sẵn sàng",
                  style: TextStyle(
                      color: (widget.product.quantity != 0 &&
                                  widget.product.quantity != null) ||
                              (widget.product.category == 1 &&
                                  widget.product.status == 1)
                          ? Colors.white
                          : Colors.red),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ProductSizeBloc, ProductSizeState>(
            builder: (context, state) {
              ProductPriceSize? prd;
              try {
                prd = state.productSize.firstWhere(
                  (element) => element.productId == widget.product.id,
                );
              } catch (e) {}

              if (state.productSize.isNotEmpty && prd != null) {
                //call transform new price follow size if has size

                List<ProductPriceSize> prd = state.productSize
                    .where((element) => element.productId == widget.product.id)
                    .toList();
                return DropdownButton(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  style: TextStyle(
                      fontSize: 16, color: colorScheme(context).scrim),
                  isDense: true,
                  value: idSelected,
                  items: [
                    DropdownMenuItem(
                      child: Text("-- loại"),
                      value: 0,
                    ),
                    ...prd.map((e) {
                      return DropdownMenuItem(
                        child: Text(e.sizeName ?? ""),
                        value: e.id,
                      );
                    }).toList()
                  ],
                  onChanged: (value) {
                    print("CHANGED");
                    setState(() {
                      idSelected = value ?? 0;
                    });
                    productBloc.add(OnChangeSizeTransformPrice(
                        idSize: idSelected, productId: widget.product.id));
                  },
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
