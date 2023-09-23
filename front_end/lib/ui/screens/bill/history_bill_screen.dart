import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
// ignore: library_prefixes
import 'package:restaurant_manager_app/model/bill_history.dart' as Model;
class HistoryBillScreen extends StatefulWidget {
  const HistoryBillScreen({super.key});

  @override
  State<HistoryBillScreen> createState() => _HistoryBillScreenState();
}
class _HistoryBillScreenState extends State<HistoryBillScreen> with SingleTickerProviderStateMixin{
  
  final List<Model.BillHistory> bills = [
    Model.BillHistory(id: "HD06748", table: 01, money: 10000, dateTime: DateTime(2023, 09, 07), status: "Đã hoàn thành"),
    Model.BillHistory(id: "HD03814", table: 02, money: 230000, dateTime: DateTime(2023, 09, 07), status: "Đã hoàn thành"),
    Model.BillHistory(id: "HD09573", table: 04, money: 150000, dateTime: DateTime(2023, 09, 06),status: "Đã hoàn thành"),
    Model.BillHistory(id: "HD01157", table: 06, money: 80000, dateTime: DateTime(2023, 09, 05), status: "Đã hoàn thành"),
    Model.BillHistory(id: "HD00576", table: 03, money: 92000, dateTime: DateTime(2023, 09, 04), status: "Đã hoàn thành"),
    Model.BillHistory(id: "HD04628", table: 01, money: 392000, dateTime: DateTime(2023, 09, 03), status: "Đã hoàn thành"),
    Model.BillHistory(id: "HD06748", table: 06, money: 912000, dateTime: DateTime(2023, 09, 02), status: "Đã hoàn thành"),
    Model.BillHistory(id: "HD06748", table: 06, money: 912000, dateTime: DateTime(2023, 09, 02), status: "Đã hoàn thành"),
    Model.BillHistory(id: "HD06748", table: 06, money: 912000, dateTime: DateTime(2023, 09, 02), status: "Đã hoàn thành"),
    Model.BillHistory(id: "HD06748", table: 06, money: 912000, dateTime: DateTime(2023, 09, 02), status: "Đã hoàn thành"),
    ];
  DateTime? selectedDate;
   @override
   Scaffold build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
          child:AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: colorScheme(context).onSecondary,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: colorScheme(context).scrim,
            ),
          ),
          title: Text(
            'LỊCH SỬ HÓA ĐƠN',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16,fontWeight: FontWeight.w900),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 280.0,
                  height: 38.0,
                    child: TextField(
                      decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: colorScheme(context).onSurfaceVariant,
                        size: 20.0,
                      ),
                      filled: true,
                      fillColor: colorScheme(context).tertiary,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme(context).outline,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: colorScheme(context).outline,
                          width: 2.0
                        )
                      ),
                      hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 12),
                      hintText: 'Tìm kiếm...',
                      contentPadding: const EdgeInsets.all(5.0), 
                      ),
                    ), 
                  ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: colorScheme(context).scrim,
                  ),
                  label: Text("Filter",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13, color: colorScheme(context).scrim),),
                  onPressed: () {},  
                )
              ],
            ),
            // TabBar(
            //   controller:
            //       TabController(length: 3, vsync: this, initialIndex: 0),
            //   tabs: const [
            //     Tab(
            //       child: Text("Tất cả"),
            //     ),
            //     Tab(
            //       child: Text("Hôm nay"),
            //     ),
            //     Tab(
            //       child: Text("Tuần"),
            //     )
            //   ]),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (bills.isNotEmpty) ...[
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: bills.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, int index) {
                          return Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bills[index].id,
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15,fontWeight: FontWeight.bold, color: colorScheme(context).scrim),
                                    ),
                                    Text(
                                      'BÀN: ${bills[index].table}',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, color: colorScheme(context).outlineVariant),
                                    ),
                                    const SizedBox(height: 5.0,),
                                    Container(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                      color: Colors.greenAccent.withOpacity(0.1),
                                      child:  Text(
                                        bills[index].status,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "${NumberFormat("#######.000", "en_US").format(bills[index].money*0.001)} đ",
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15, fontWeight: FontWeight.bold, color: colorScheme(context).scrim),
                                    ),
                                    Text(
                                      DateFormat("dd-MM-yyyy").format(bills[index].dateTime),
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, color: colorScheme(context).outlineVariant),
                                    ),
                                  ],
                                )
                              ]
                            ),
                          );
                        },
                      ),
                    ] else ...[
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 150),
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/svgs/icon_empty_bill.svg',
                          width: 100,
                          height: 100,
                          ),
                          Text(
                            "Hiện tại không có hóa đơn nào !",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15, color: colorScheme(context).outline),
                          ),
                        ]
                      ),
                      )
                      
                    ]
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
   }
}