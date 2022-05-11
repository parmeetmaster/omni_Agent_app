import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:six_cash/util/color_resources.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = ColorResources.getPrimaryTextColor();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;

    var startPoint = Offset(size.width/3, size.height / 100);
    var controlPoint1 = Offset(size.width / 4, size.height / 30);
    var controlPoint2 = Offset(3 * size.width / 4, size.height / 3);
    var endPoint = Offset(size.width-30, size.height / 2);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy-50);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy-100, controlPoint2.dx -100 ,
        controlPoint2.dy-100, endPoint.dx-100, endPoint.dy-50);

    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(<double>[10.0, 5]),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}