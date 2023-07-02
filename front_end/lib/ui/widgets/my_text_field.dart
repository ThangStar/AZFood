import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class MyTextField extends StatefulWidget {
  const MyTextField(
      {super.key,
      this.label = '',
      this.hintText,
      required this.controller,
      required this.icon,
      this.obscureText = false});

  final String label;
  final String? hintText;

  final TextEditingController controller;
  final Widget icon;
  final bool obscureText;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    print("dsa: ${widget.icon})");
    return TextField(
      controller: widget.controller,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      obscureText: widget.obscureText,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w400),
          isDense: true,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: colorScheme(context).scrim.withOpacity(0.6)),
          hintText: widget.hintText,
          label: widget.label.isEmpty ? null : Text(widget.label),
          suffixIcon: widget.icon,
          fillColor: colorScheme(context).tertiary.withOpacity(0.3),
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none)),
    );
  }
}
