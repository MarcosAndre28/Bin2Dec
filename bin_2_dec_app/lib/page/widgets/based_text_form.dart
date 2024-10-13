import 'package:flutter/material.dart';

class BasedTextForm extends StatelessWidget {
  final InputDecoration? decoration;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;

  const BasedTextForm({
    super.key,
    this.decoration,
    required this.controller,
    this.keyboardType,
    this.style,
    this.onChanged,
    this.maxLength,
    this.validator,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: decoration,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: style,
      maxLength: maxLength,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
