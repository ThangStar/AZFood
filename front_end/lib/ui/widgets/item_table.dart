import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/model/table.dart' as Model;
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/utils/spacing_date_to_now.dart';

// status: 1 -> online, 2 -> error, 3 -> watting,
class ItemTable extends StatelessWidget {
  const ItemTable({super.key, required this.table, required this.onTap});

  final Model.Table table;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
            color: colorScheme(context).onPrimary.withOpacity(0.3)),
        child: ClipRRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: table.status != 3
                                ? Border.all(
                                    color: table.status == 1
                                        ? const Color(0xFF049C6B)
                                        : Colors.red,
                                    width: 2)
                                : Border.all(
                                    color: colorScheme(context).tertiary,
                                    width: 2)),
                        duration: 400.ms,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  table.name ?? "NAME",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: table.status != 3
                                              ? table.status == 1
                                                  ? const Color(0xFF049C6B)
                                                  : colorScheme(context).error
                                              : colorScheme(context)
                                                  .scrim
                                                  .withOpacity(0.8)),
                                ),
                                const SizedBox(height: 4),
                                table.firstTime != null
                                    ? Row(
                                        children: [
                                          Icon(Icons.access_time_sharp,
                                              color: colorScheme(context)
                                                  .scrim
                                                  .withOpacity(0.6),
                                              size: 18),
                                          Text(
                                            " ${spacingDateToNow(DateTime.parse(table.firstTime!))}",
                                            style: TextStyle(
                                                color: colorScheme(context)
                                                    .scrim
                                                    .withOpacity(0.6)),
                                          )
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Text(
                                    "${NumberFormat.decimalPattern().format(table.sumPrice ?? 0)} đ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: table.status != 3
                                                ? table.status == 1
                                                    ? const Color(0xFF049C6B)
                                                    : colorScheme(context).error
                                                : colorScheme(context)
                                                    .scrim
                                                    .withOpacity(0.8))),
                                const Spacer(),
                                table.status == 2
                                    ? IconButton(
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.green)),
                                        color: Colors.white,
                                        onPressed: () {},
                                        icon: SvgPicture.asset(
                                          "assets/svgs/clean.svg",
                                          color: Colors.white,
                                        ))
                                    : const SizedBox.shrink()
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
