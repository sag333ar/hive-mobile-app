import 'package:flutter/material.dart';
import 'package:hive_mobile_app/gen/assets.gen.dart';

class HiveSymbolLogo extends StatelessWidget {
  const HiveSymbolLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.images.hiveSymbolLogo.path,
      width: 32,
      height: 32,
    );
  }
}
