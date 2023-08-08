import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/model/table.dart' as Model;
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

// status: 0 -> watting, 1 -> online, 2 -> error
class ItemTable extends StatelessWidget {
  const ItemTable({super.key, required this.table});
  final Model.Table table;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
            color: colorScheme(context).tertiary.withOpacity(0.3)),
        child: ClipRRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      print("object");
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: table.status != 0
                                ? Border.all(
                                    color: table.status == 1
                                        ? const Color(0xFF049C6B)
                                        : Colors.red)
                                : null),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              table.tableName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: table.status == 1
                                          ? const Color(0xFF049C6B)
                                          : colorScheme(context)
                                              .scrim
                                              .withOpacity(0.8)),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.access_time_sharp),
                                Text(" ${table.time}")
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text(
                                    "${NumberFormat.decimalPattern().format(table.sumPrice)} đ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        color:  table.status == 1
                                          ? const Color(0xFF049C6B)
                                          : colorScheme(context)
                                              .scrim
                                              .withOpacity(0.8))),
                                table.status == 2
                                    ? Icon(Icons.error, color: Colors.red)
                                    : SizedBox.shrink()
                              ],
                            )
                          ],
                        )),
                  ),
                ))),
      ),
    );
  }
}
