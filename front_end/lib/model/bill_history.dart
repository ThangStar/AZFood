import 'dart:ffi';

class BillHistory {
  final int id;
  final int table;
  final double money;

  BillHistory( 
      {required this.id,
      required this.table,
      required this.money,
      });
}