import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
        automaticallyImplyLeading:
            checkDevice(widget.constraints?.maxWidth ?? 0, true, false, false),
        title: Text("Hoá đơn", style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            ),
      ),
      body: Column(
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
          TabBar(
              controller:
                  TabController(length: 2, vsync: this, initialIndex: 0),
              tabs: const [
                Tab(
                  child: Text("Gần đây"),
                ),
                Tab(
                  child: Text("Tất cả"),
                )
              ]),
          Expanded(
            child: BlocBuilder<InvoiceBloc, InvoiceState>(
              builder: (context, state) {
                if (state is InvoiceLoadingState) {
                  return const Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: AspectRatio(
                          aspectRatio: 1, child: CircularProgressIndicator()),
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: checkDevice(widget.constraints?.maxWidth ?? 0, 1, 2, 3), mainAxisExtent: 95),
                  );
                } else {
                  return const Column(
                    children: [Text("Không tìm thấy hoá đơn nào")],
                  );
                }
              },
            ),
          )
        ],
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
        onTap: () {},
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
                    "${invoice.createAt!.toLocal()}",
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
