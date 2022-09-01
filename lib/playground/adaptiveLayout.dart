import 'package:flutter/material.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    required this.children,
    required this.mainAxisAlignment
  }): super();
  final List<Widget> children;
  final MainAxisAlignment  mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, dimens) {
        if (dimens.maxWidth < 600) { // mobile layout
          return Column(children: children, mainAxisAlignment: mainAxisAlignment);
        } else { // desktop layout
          return Row(children: children, mainAxisAlignment: mainAxisAlignment);
        }
      }
    );
  }
}