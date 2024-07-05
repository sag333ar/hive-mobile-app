import 'package:flutter/material.dart';

class DenseIconButton extends StatelessWidget {
  const DenseIconButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      this.color,
      this.size});

  final VoidCallback onPressed;
  final IconData icon;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        iconSize: size ?? 20,
        color: color,
        onPressed: onPressed,
        icon: Icon(icon));
  }
}
