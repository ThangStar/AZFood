import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/ui/screens/bill/detail_bill_screen.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_menu.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button.dart';

enum PayStatus { success, failed }

class BillData {
  final int idInvoice;
  final int sumPrice;
  final String username;
  final String time;

  BillData(
      {required this.idInvoice,
      required this.sumPrice,
      required this.username,
      required this.time});
}

class PaySuccessScreen extends StatelessWidget {
  const PaySuccessScreen(
      {super.key, required this.payStatus, required this.billData});

  final PayStatus payStatus;

  final BillData? billData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: payStatus == PayStatus.success
              ? colorScheme(context).surfaceTint
              : colorScheme(context).error,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: colorScheme(context).onPrimary.withOpacity(0.8),
                  ),
                  borderRadius: BorderRadius.circular(80)),
              child: Icon(
                Icons.question_mark_outlined,
                color: colorScheme(context).onPrimary.withOpacity(0.8),
              ),
            )
          ],
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
            color: colorScheme(context).onPrimary,
          ),
          title: Text(
            payStatus == PayStatus.success
                ? "Đã xuất hoá đơn"
                : "Đã xảy ra lỗi",
            style:
                TextStyle(fontSize: 22, color: colorScheme(context).onPrimary),
          ),
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(200),
              child: SizedBox(
                  height: 200,
                  child: Center(
                      child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: colorScheme(context).onPrimary, width: 6),
                        borderRadius: BorderRadius.circular(100)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        payStatus == PayStatus.success
                            ? Icons.done_outlined
                            : Icons.close,
                        color: colorScheme(context).onPrimary,
                        size: 80,
                      ),
                    ),
                  )))),
        ),
        body: billData != null
            ? BodyBillSuccess(
                billData: billData,
              )
            : const SizedBox.shrink());
  }
}

class BodyBillSuccess extends StatelessWidget {
  const BodyBillSuccess({super.key, required this.billData});

  final BillData? billData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Container(
              color: colorScheme(context).onPrimary,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Text(
                      "Mã hoá đơn: ",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "HD00${billData?.idInvoice ?? 0}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              color: colorScheme(context).onPrimary,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            "Tổng tiền: ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "${NumberFormat.decimalPattern().format(billData?.sumPrice ?? 0)} đ",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            "Nhân viên: ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            billData?.username ?? "username",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            "Thời gian: ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            billData?.time ?? "",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MyButton(
                isOutline: true,
                value: "Quay về",
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeMenuScreen(),
                      ),
                      (route) => false);
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MyButton(
                value: "Xem hoá đơn",
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailBillScreen(),
                      ),
                      (route) => false);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
