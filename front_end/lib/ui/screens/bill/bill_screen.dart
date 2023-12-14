import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/ui/screens/bill/detail_bill_screen.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_menu.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';

import '../../../model/invoice.dart';
import '../../blocs/invoice/invoice_bloc.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key, this.constraints});

  final BoxConstraints? constraints;

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    context.read<InvoiceBloc>().add(GetInvoiceEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: colorScheme(context).onPrimary,
        titleSpacing: checkDevice(widget.constraints?.maxWidth ?? 0, -5.0, 20.0, 20.0),
        leading: checkDevice(
            widget.constraints?.maxWidth ?? 0,
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeMenuScreen(),
                    ),
                    (route) => false);
              },
            ),
            null,
            null),
        title: Text(
          'HÓA ĐƠN',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: SearchBar(
                  textStyle: const MaterialStatePropertyAll(TextStyle(
                    fontSize: 16,
                  )),
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 10, vertical: 4)),
                  hintText: "Tìm theo tên, mã..",
                  elevation: const MaterialStatePropertyAll(0),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      side: BorderSide(color: colorScheme(context).tertiary),
                      borderRadius: BorderRadius.circular(6))),
                  trailing: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                  ],
                ),
              ),
            ),
            DefaultTabController(
                length: 2,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 136,
                  child: Column(
                    children: [
                      const TabBar.secondary(tabs: [
                        Tab(
                          child: Text("Tất cả1"),
                        ),
                        Tab(
                          child: Text("Gần đây1"),
                        )
                      ]),
                      Expanded(
                        child: TabBarView(children: [
                          BlocBuilder<InvoiceBloc, InvoiceState>(
                            builder: (context, state) {
                              if (state is InvoiceLoadingState) {
                                return const Center(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: AspectRatio(
                                        aspectRatio: 1,
                                        child: CircularProgressIndicator()),
                                  ),
                                );
                              } else if (state.invoices.isNotEmpty) {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemBuilder: (context, index) {
                                    Invoice invoice = state.invoices[index];
                                    return ItemBill(
                                      invoice: invoice,
                                    ).animate().fade(duration: 1.seconds).moveY(
                                        duration: 1.seconds,
                                        begin: 50 * index.toDouble() ?? 0.0,
                                        curve: Curves.fastOutSlowIn);
                                  },
                                  itemCount: state.invoices.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: checkDevice(
                                              widget.constraints?.maxWidth ?? 0,
                                              1,
                                              2,
                                              3),
                                          mainAxisExtent: 95),
                                );
                              } else {
                                return Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svgs/icon_empty_bill.svg',
                                          width: 100,
                                          height: 100,
                                        ),
                                        Text(
                                          "Hiện tại không có hóa đơn nào !",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                  fontSize: 15,
                                                  color: colorScheme(context)
                                                      .outline),
                                        ),
                                      ]),
                                );
                              }
                            },
                          ),
                          Center(
                            child: Text("tab2"),
                          ),
                        ]),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class ItemBill extends StatelessWidget {
  final Invoice invoice;

  const ItemBill({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: Border.all(color: colorScheme(context).scrim.withOpacity(0.1)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailBillScreen(
                      id: invoice.id ?? 0,
                    )),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoice.tableName ?? "tableName",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "HD00${invoice.id}" ?? "TB001",
                    style: TextStyle(
                        fontSize: 14,
                        color: colorScheme(context).scrim.withOpacity(0.4)),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    color: Colors.pinkAccent.withOpacity(0.1),
                    child: Text(
                      "B00${invoice.id}",
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${NumberFormat.decimalPattern().format(invoice.total ?? 0)} đ",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    DateFormat('HH:mm dd/MM/yyyy').format(invoice.createAt!),
                    style: TextStyle(
                        color: colorScheme(context).scrim.withOpacity(0.4)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
