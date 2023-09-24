
import 'package:flutter/material.dart';

class BillHistory {
  final String id;
  final int table;
  final double money;
  final DateTime dateTime;
  final String status;

  BillHistory( 
      {required this.id,
      required this.table,
      required this.money,
      required this.dateTime,
      required this.status,
      });
}