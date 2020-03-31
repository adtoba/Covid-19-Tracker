import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  String title;
  String subtitle;
  String iconData;
  Color iconColor;
  Function onPressed;

  InfoCard(
      {@required this.iconData, @required this.title, @required this.subtitle, @required this.iconColor,  @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    return GestureDetector(
      onTap: onPressed,
          child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Container(
            width: width,
            height: 100.0,
            child: ListTile(
              leading: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration:
                      BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
                  child: Center(
                    child: ImageIcon(
                      AssetImage("$iconData",), color: iconColor,
                    ),
                  )),
              title: Text(
                '$title',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                "$subtitle",
                style: TextStyle(color: Colors.grey),
              ),
            )),
      ),
    );
  }
}
