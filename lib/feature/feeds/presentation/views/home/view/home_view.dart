import 'package:flutter/material.dart';
import 'package:hive_mobile_app/feature/feeds/presentation/views/home/view/mobile_home_view.dart';
import 'package:hive_mobile_app/feature/feeds/presentation/views/home/view/web_home_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) {
        return MobileHomeView();
      },
      tablet: (p0) => WebHomeView(),
      desktop: (_) => WebHomeView(),
    );
  }
}
