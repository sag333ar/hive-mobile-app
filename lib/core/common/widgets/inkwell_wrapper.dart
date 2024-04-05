import 'package:flutter/material.dart';

class InkWellWrapper extends StatelessWidget {
  const InkWellWrapper({super.key, required this.child,  this.onTap});

  final Widget child;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap:onTap,
              child: const SizedBox(),
            ),
          ),
        )
      ],
    );
  }
}
