import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:restaurant_manager_app/ui/blocs/invoice/invoice_bloc.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';

class DetailBillScreen extends StatefulWidget {
  const DetailBillScreen({super.key, required this.id});

  final int id;

  @override
  State<DetailBillScreen> createState() => _detailBillState();
}

class _detailBillState extends State<DetailBillScreen> {
  late InvoiceBloc invoiceBloc;
  @override
  void initState() {
    invoiceBloc = BlocProvider.of<InvoiceBloc>(context);
    invoiceBloc.add(GetInvoiceByIdEvent(id: widget.id));
    print(invoiceBloc.state.invoice);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55.0),
          child: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: colorScheme(context).onPrimary,
            titleSpacing: -5.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: colorScheme(context).scrim,
              ),
            ),
            title: Text(
              'CHI TIẾT HÓA ĐƠN',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        body: Center(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: SizedBox(
                width: checkDevice(size.width, 500.0, 600.0, 1000.0),
                child: Center(
                  child: Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                HeaderBill(),
                                BodyBill(),
                                FooterBill(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 55,
                        right: 14,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                                topLeft: Radius.circular(100)),
                            color: colorScheme(context).background,
                            shape: BoxShape.rectangle,
                          ),
                          height: 45,
                          width: 25,
                        ),
                      ),
                      Positioned(
                        top: 55,
                        left: 14,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(100),
                                bottomRight: Radius.circular(100)),
                            color: colorScheme(context).background,
                            shape: BoxShape.rectangle,
                          ),
                          height: 45,
                          width: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class FooterBill extends StatelessWidget {
  const FooterBill({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: BlocBuilder<InvoiceBloc, InvoiceState>(builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tổng tiền:',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                Text(
                  '${NumberFormat.decimalPattern().format(state.invoice?.total ?? 0).replaceAll(',', '.')} đ',
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class BodyBill extends StatelessWidget {
  const BodyBill({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0XFFD4D4D8).withOpacity(0.3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(
              'assets/svgs/check_bill.svg',
              width: 84,
              height: 84,
            ),
          ),
          const Text(
            'THÔNG TIN HÓA ĐƠN',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: BlocBuilder<InvoiceBloc, InvoiceState>(
                builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(width: double.infinity, height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Mã hóa đơn',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      Text(
                        "HD00${state.invoice?.id ?? 0}",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(width: double.infinity, height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Số bàn',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      Text(
                        state.invoice?.tableName ?? "",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(width: double.infinity, height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Số lượng món',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      Text(
                        '12',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(width: double.infinity, height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Thu ngân',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      Text(
                        state.invoice?.userName ?? "",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(width: double.infinity, height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Đã vào bàn lúc',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45),
                      ),
                      Text(
                        '3h40p, ngày 25/8/2023',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(width: double.infinity, height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Đã xuất hóa đơn lúc',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45),
                      ),
                      const SizedBox(width: 10.0),
                      Flexible(
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                          var flexibleSize = constraints.maxWidth;
                          return SizedBox(
                            width: 180.0,
                            height: 20.0,
                            child: flexibleSize < 180
                              ? Marquee(
                                  text: DateFormat("HH'h'mm'p,' 'ngày' dd/MM/yyyy").format(state.invoice?.createAt ?? DateTime.now()),
                                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  blankSpace: 20.0,
                                  velocity: 50.0,
                                  pauseAfterRound: const Duration(seconds: 1),
                                  startPadding: 10.0,
                                  accelerationDuration: const Duration(seconds: 1),
                                  accelerationCurve: Curves.linear,
                                  decelerationDuration:const Duration(milliseconds: 500),
                                  decelerationCurve: Curves.easeOut,
                                )
                              : Text(
                                  DateFormat("HH'h'mm'p,' 'ngày' dd/MM/yyyy").format(state.invoice?.createAt ?? DateTime.now()),
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                                ),
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(width: double.infinity, height: 15),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class HeaderBill extends StatelessWidget {
  const HeaderBill({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0XFF8E2DE2), Color(0XFF4A00E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('29-8-2023',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.3),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              ),
              child: const Text(
                'Chi tiết món',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
