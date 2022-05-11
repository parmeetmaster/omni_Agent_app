import 'package:flutter/material.dart';

import 'curve_painter.dart';

class DrawingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Curved Line"),
      ),
      body: CustomPaint(
        painter: CurvePainter(),
        child: Container(),
      ),
    );
  }
}