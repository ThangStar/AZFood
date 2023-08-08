import 'package:flutter/material.dart';

class MyCheckBox extends StatelessWidget {
  const MyCheckBox({super.key, required this.value, required this.onChanged});
  final bool value;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: value, onChanged: (v)=> onChanged(v));
  }
}
