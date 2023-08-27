import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class MyTextField extends StatefulWidget {
  const MyTextField(
      {super.key,
      this.label = '',
      this.hintText,
      required this.controller,
      required this.icon,
      this.isPassword = false,
      this.isShowPass = false,
      this.validator,
      this.onChanged});

  final String label;
  final String? hintText;
  final TextEditingController controller;
  final Widget icon;
  final bool isPassword;
  final bool isShowPass;
  final Function(String)? onChanged;
  final String Function(String?)? validator;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isFocus = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (value) {
          setState(() {
            isFocus = value;
          });
        },
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return widget.validator != null ? widget.validator!(value) : null;
          },
          keyboardType: TextInputType.emailAddress,
          controller: widget.controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onChanged: widget.onChanged,
          obscureText: widget.isShowPass,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w400),
              isDense: true,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme(context).scrim.withOpacity(0.6)),
              hintText: widget.hintText,
              label: widget.label.isEmpty ? null : Text(widget.label),
              suffixIcon: widget.icon,
              fillColor: colorScheme(context).tertiary.withOpacity(0.3),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:
                      isFocus ? const BorderSide(width: 1) : BorderSide.none)),
        ),
      ),
    );
  }
}
