import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/model/product_booking.dart';
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
  Widget build(BuildContext context) {
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
                ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    ProductBooking productBooking = ProductBooking(
                        name: "name",
                        type: "type",
                        money: 1,
                        amount: 1,
                        image:
                            "https://thumbs.dreamstime.com/b/hamberger-sauce-piece-big-hamburger-close-up-shot-snack-drink-background-144073056.jpg");
                    return ItemProduct(
                        productBooking: productBooking,
                        subTitle: Text("subTitle"),
                        trailling: Text("das"));
                  },
                )
              ],
            ),
          )),
    );
  }
}
