import 'package:flutter/material.dart';

Position getPositionByKey(GlobalKey key) {
  RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
  Size size = box.size;
  Offset position = box.localToGlobal(Offset.zero); //this is global position
  double x = position.dx;
  double y = position.dy;
  return Position(x, y, size);
}

class Position {
  double x;

  double y;
  Size size;

  Position(this.x, this.y, this.size);
}
