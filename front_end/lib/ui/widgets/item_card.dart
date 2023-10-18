import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({
    super.key,
    required this.fistColor,
    required this.secondColor,
    required this.heights,
    required this.count,
    required this.titleCard,
    required this.percent,
  });
  final Color fistColor;
  final Color secondColor;
  final List<double> heights;
  final int count;
  final String titleCard;
  final double percent;
  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15.0),
      decoration: BoxDecoration(
        color: colorScheme(context).onPrimary,
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 3,
            offset: const Offset(0, 3), 
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: colorScheme(context).primary.withOpacity(0.3),
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(18.0)),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.count}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: 30,
                                  color: widget.secondColor)),
                      Text(widget.titleCard,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style:
                              TextStyle(color: colorScheme(context).outline)),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                const Color.fromRGBO(147, 155, 163, 1),
                            radius: 10,
                            child: Icon(
                              Icons.arrow_outward_rounded,
                              size: 12,
                              color: colorScheme(context).onPrimary,
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          Text("${widget.percent}%",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: const Color.fromRGBO(
                                          147, 155, 163, 1))),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 20.0,
                      height: widget.heights[0],
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: widget.fistColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    SizedBox(
                      width: 20.0,
                      height: widget.heights[1],
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: widget.fistColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    SizedBox(
                      width: 20.0,
                      height: widget.heights[2],
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: widget.fistColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    SizedBox(
                      width: 20.0,
                      height: widget.heights[3],
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: widget.fistColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    SizedBox(
                      width: 20.0,
                      height: widget.heights[4],
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: widget.secondColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2.0)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
