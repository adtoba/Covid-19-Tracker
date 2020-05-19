import 'dart:math';

import 'package:covid19/utils/colors.dart';
import 'package:flutter/material.dart';


class ChartPainter extends CustomPainter {

  Paint _paint;

  ChartPainter() {
    _paint = Paint()
    ..color = MkColors.iconColor
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 3.0;
  }

  @override
  void paint(Canvas canvas, Size size) {

   
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    
    return false;
  }
}