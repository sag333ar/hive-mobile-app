import 'package:flutter/material.dart';

class ResponsiveGridView extends StatelessWidget {
  const ResponsiveGridView(
      {super.key,
      this.paginationLoader,
      required this.itemCount,
      this.childAspectRatio,
      this.crossAxisSpacing,
      this.mainAxisSpacing,
      required this.itemBuilder,
      this.screenWidth,
      this.isSliver = false, this.decrementedWidth});

  final Widget? paginationLoader;
  final int itemCount;
  final double? childAspectRatio;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final Widget? Function(BuildContext, int) itemBuilder;
  final bool isSliver;
  final double? screenWidth;
  final double? decrementedWidth;

  @override
  Widget build(BuildContext context) {
    final screenWidth = this.screenWidth ?? (MediaQuery.of(context).size.width - (decrementedWidth ?? 0));
    int crossAxisCount = getCrossAxisCount(screenWidth);
    return isSliver
        ? _sliverGrid(crossAxisCount)
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: CustomScrollView(
              shrinkWrap: true,
              controller: ScrollController(),
              slivers: [
                _sliverGrid(crossAxisCount),
                SliverToBoxAdapter(
                    child: paginationLoader ?? const SizedBox.shrink()),
              ],
            ),
          );
  }

  SliverGrid _sliverGrid(int crossAxisCount) {
    return SliverGrid.builder(
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio ?? 1,
          crossAxisSpacing: crossAxisSpacing ?? 1,
          mainAxisSpacing: mainAxisSpacing ?? 1,
        ),
        itemBuilder: itemBuilder);
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
