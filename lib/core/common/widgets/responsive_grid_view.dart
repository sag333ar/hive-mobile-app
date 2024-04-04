import 'package:flutter/material.dart';

class ResponsiveGridView extends StatelessWidget {
  const ResponsiveGridView({
    super.key,
    required this.paginationLoader,
    required this.itemCount,
    this.childAspectRatio,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    required this.itemBuilder,
  });

  final Widget paginationLoader;
  final int itemCount;
  final double? childAspectRatio;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = getCrossAxisCount(screenWidth);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: CustomScrollView(
        controller: ScrollController(),
        slivers: [
          SliverGrid.builder(
              itemCount: itemCount,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio ?? 1,
                crossAxisSpacing: crossAxisSpacing ?? 1,
                mainAxisSpacing: mainAxisSpacing ?? 1,
              ),
              itemBuilder: itemBuilder),
          SliverToBoxAdapter(child: paginationLoader),
        ],
      ),
    );
  }

  int getCrossAxisCount(double width) {
    if (width > 1300) {
      return 4;
    } else if (width > 974 && width < 1300) {
      return 3;
    } else if (width > 650 && width < 974) {
      return 2;
    } else {
      return 2;
    }
  }
}
