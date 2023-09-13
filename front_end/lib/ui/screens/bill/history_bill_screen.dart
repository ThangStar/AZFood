import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/model/bill_history.dart' as Model;
import 'dart:math' as math;

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
class HistoryBillScreen extends StatefulWidget {
  const HistoryBillScreen({super.key});

  @override
  State<HistoryBillScreen> createState() => _HistoryBillScreenState();
}
class _HistoryBillScreenState extends State<HistoryBillScreen> {
  final List<Model.BillHistory> bills = [
    Model.BillHistory(id: 01, table: 01, money: 10),
    Model.BillHistory(id: 02, table: 02, money: 230),
    Model.BillHistory(id: 03, table: 04, money: 150),
    Model.BillHistory(id: 04, table: 06, money: 80),
    Model.BillHistory(id: 05, table: 03, money: 92),
    Model.BillHistory(id: 06, table: 01, money: 392),
    Model.BillHistory(id: 07, table: 06, money: 912),
    ];
  final List<DateTime> dates = [
    DateTime.now(),
    DateTime(2023, 09, 07),
    DateTime(2023, 09, 06),
    DateTime(2023, 09, 05),
  ];  

  String dropdownValue = list.first;
  
  DateTime? selectedDate;
   @override
   Scaffold build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme(context).scrim,
          ),
        ),
        title: Text(
          'Cập nhật thông tin',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
        ),
        shape: Border(
          bottom: BorderSide(
            color: colorScheme(context).outline,
            width: 2
          )
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
                  width: 150.0,
                    child: DropdownButton<DateTime>(
                      underline: Container(),
                      hint: const Text('Chọn ngày'),
                      value: selectedDate,
                      isExpanded: true,
                      icon: Transform.rotate(
                        angle: 270 *math.pi /180,
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: colorScheme(context).scrim,
                          size: 16,
                        ), 
                      ),
                      
                    onChanged: (DateTime? value) {
                      setState(() {
                        selectedDate = value!;
                      });
                    },
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12, color: colorScheme(context).scrim),
                    items: dates.map<DropdownMenuItem<DateTime>>((DateTime value) {
                      return DropdownMenuItem<DateTime>(
                        value: value,
                        child: Text(DateFormat('dd/MM/yyyy').format(value)),
                      );
                    }).toList(),
                    ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: colorScheme(context).primaryContainer, 
                  ),
                  child: Center(
                    child: Text("Trang 1/3", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12, color: colorScheme(context).primary),),
                  ),
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: bills.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: colorScheme(context).primaryContainer,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                  width: sizeScreen.width*0.08,
                                  height: sizeScreen.height * 0.08,
                                  'assets/svgs/icon_bill.svg'),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mã hóa đơn ${bills[index].id}',
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14,fontWeight: FontWeight.bold, color: colorScheme(context).primary),
                                      ),
                                      Text(
                                        'Bàn: ${bills[index].table}',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, color: colorScheme(context).scrim),
                                      ),
                                    ],
                                  ),
                                ]
                              ),
                              Text("${bills[index].money} đ", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12, color: Colors.green),)
                            ],
                          ),
                          
                        );
                      },
                    ),
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