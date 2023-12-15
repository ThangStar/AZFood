import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:restaurant_manager_app/model/table.dart' as Model;
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/utils/spacing_date_to_now.dart';

import '../blocs/table/table_bloc.dart';

// status: 1 -> online, 2 -> error, 3 -> watting,
class ItemTable extends StatefulWidget {
  const ItemTable({super.key, required this.table, required this.onTap});

  final Model.Table table;
  final Function() onTap;

  @override
  State<ItemTable> createState() => _ItemTableState();
}

class _ItemTableState extends State<ItemTable> {
  List<Color> colorizeColors = [
    Color(0xFF049C6B),
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  TextStyle colorizeTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

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
                    onTap: widget.onTap,
                    child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: widget.table.status != 3
                                ? Border.all(
                                    color: widget.table.status == 1
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
                                widget.table.status == 1
                                    ? AnimatedTextKit(
                                        repeatForever: true,
                                        animatedTexts: [
                                          ColorizeAnimatedText(
                                            "${widget.table.name}",
                                            textStyle: colorizeTextStyle,
                                            colors: colorizeColors,
                                          ),
                                        ],
                                        isRepeatingAnimation: true,
                                        onTap: () {
                                          print("Tap Event");
                                        },
                                      )
                                    : Text(
                                        widget.table.name ?? "NAME",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: widget.table.status != 3
                                                    ? widget.table.status == 1
                                                        ? const Color(
                                                            0xFF049C6B)
                                                        : colorScheme(context)
                                                            .error
                                                    : colorScheme(context)
                                                        .scrim
                                                        .withOpacity(0.8)),
                                      ),
                                const SizedBox(height: 4),
                                widget.table.firstTime != null
                                    ? Row(
                                        children: [
                                          Icon(Icons.access_time_sharp,
                                              color: colorScheme(context)
                                                  .scrim
                                                  .withOpacity(0.6),
                                              size: 18),
                                          Text(
                                            " ${spacingDateToNow(DateTime.parse(widget.table.firstTime!))}",
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
                                    "${NumberFormat.decimalPattern().format(widget.table.sumPrice ?? 0)} đ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: widget.table.status != 3
                                                ? widget.table.status == 1
                                                    ? const Color(0xFF049C6B)
                                                    : colorScheme(context).error
                                                : colorScheme(context)
                                                    .scrim
                                                    .withOpacity(0.8))),
                                const Spacer(),
                                widget.table.status == 2
                                    ? InkWell(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        splashColor:
                                            Colors.blue.withOpacity(0.4),
                                        hoverColor:
                                            Colors.blue.withOpacity(0.2),
                                        onTap: () {
                                          context.read<TableBloc>().add(
                                              UpdateStatusEvent(
                                                  idTable: widget.table.id ?? 0,
                                                  status: 3 ));
                                        },
                                        child: const Icon(
                                          Ionicons.arrow_forward_circle_outline,
                                          size: 38,
                                          color: Colors.black45,
                                        ))
                                    : const SizedBox.shrink()
                              ],
                            ),
                          ],
                        )),
                  ),
                ))),
      ),
    );
  }
}
