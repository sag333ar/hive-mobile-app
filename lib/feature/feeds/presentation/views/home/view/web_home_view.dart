import 'package:flutter/material.dart';
import 'package:hive_mobile_app/core/common/widgets/hive_symbol_logo.dart';

class WebHomeView extends StatelessWidget {
  const WebHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const HiveSymbolLogo(),
      ),
    );
  }
}