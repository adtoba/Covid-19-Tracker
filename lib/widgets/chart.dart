import 'package:covid19/utils/colors.dart';
import 'package:flutter/material.dart';


class ChartDisplay extends StatelessWidget {
  const ChartDisplay({
    @required this.chartColor
  });

  final Color chartColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(18, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          height: index.toDouble() + 3,
          width: 2.0,
          color: chartColor ?? MkColors.rectangleColor,
        );
      }),
    );
  }
}