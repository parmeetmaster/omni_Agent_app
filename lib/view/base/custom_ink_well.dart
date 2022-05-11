import 'package:flutter/material.dart';
import 'package:six_cash/util/color_resources.dart';
class CustomInkWell extends StatelessWidget {
  final double radius;
  final Widget child;
  final VoidCallback onTap;
  final Color highlightColor;
  const CustomInkWell({Key key, this.radius,@required this.child,@required this.onTap, this.highlightColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius??0.0),
        highlightColor: highlightColor ?? ColorResources.getPrimaryColor().withOpacity(0.5),
        hoverColor: ColorResources.getPrimaryColor(),
        child: child,
      ),
    );
  }
}
