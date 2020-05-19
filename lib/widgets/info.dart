import 'package:flutter/material.dart';
import 'package:covid19/res/size_config.dart';
import 'package:covid19/utils/colors.dart';

class InfoBar extends StatelessWidget {
  const InfoBar({
    @required this.label,
    @required this.onPressed,
    @required this.color
  });

  final String label;
  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final SizeConfig config = SizeConfig();
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(top: config.sh(10)),
        padding: EdgeInsets.symmetric(horizontal: config.sw(10.0)),
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              label, style: const TextStyle(color: Colors.white),
            ),
            const Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
