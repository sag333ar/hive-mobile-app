import 'package:flutter/material.dart';

extension LayoutAdapter on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < mobileBreakPoint;

  bool get isTablet =>
      MediaQuery.of(this).size.width >= mobileBreakPoint &&
      MediaQuery.of(this).size.width < tabletBreakPoint;

  bool get isDesktop => MediaQuery.of(this).size.width >= tabletBreakPoint;

  double get mobileBreakPoint => 600;
  double get tabletBreakPoint => 950;
}
