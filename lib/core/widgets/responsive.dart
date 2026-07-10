import 'package:flutter/material.dart';

class Responsive {
  const Responsive._();

  static const double phone = 600;
  static const double tablet = 900;

  static bool isTabletWidth(double width) => width >= phone;

  static int homeMenuColumns(double width) {
    if (width >= tablet) return 6;
    if (width >= phone) return 5;
    return 4;
  }

  static int compactGridColumns(double width) {
    if (width >= tablet) return 6;
    if (width >= phone) return 5;
    return 4;
  }

  static int videoColumns(double width) {
    if (width >= 1100) return 4;
    if (width >= phone) return 3;
    return 2;
  }

  static double contentMaxWidth(double width) {
    if (width >= 1100) return 920;
    if (width >= tablet) return 820;
    if (width >= phone) return 680;
    return double.infinity;
  }
}

class ResponsiveBox extends StatelessWidget {
  const ResponsiveBox({
    super.key,
    required this.child,
    this.padding,
    this.maxWidth,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final effectiveMaxWidth = maxWidth ?? Responsive.contentMaxWidth(width);
        final sidePadding = width >= Responsive.phone ? 20.0 : 0.0;

        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: effectiveMaxWidth),
            child: Padding(
              padding: padding ?? EdgeInsets.symmetric(horizontal: sidePadding),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
