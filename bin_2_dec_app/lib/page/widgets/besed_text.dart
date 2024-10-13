import 'package:flutter/material.dart';

class BesedText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const BesedText({super.key, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: TextAlign.start,
    );
  }
}
