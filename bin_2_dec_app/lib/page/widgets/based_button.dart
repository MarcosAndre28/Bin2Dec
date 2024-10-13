import 'package:flutter/material.dart';

class BasedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final ButtonStyle? style;

  const BasedButton({super.key, this.onPressed, this.child, this.style});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: child,
    );
  }
}
