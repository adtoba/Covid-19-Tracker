import 'package:covid19/utils/colors.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key key, this.opacity = 1.0, this.label = ''})
      : super(key: key);

  final double opacity;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: MkColors.black,
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
