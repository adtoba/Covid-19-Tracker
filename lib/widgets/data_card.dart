import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  DataCard({@required this.title, @required this.value, @required this.icon, @required this.onPressed, this.textColor});

  final ImageIcon icon;
  final String title;
  final String value;
  final Function onPressed;
  Color textColor;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double deviceHeight = size.height;
    double deviceWidth = size.width;

    return InkWell(
      onTap: onPressed,
          child: Container(
          width: deviceWidth,
          height: 60.0,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey[500]),
              borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(alignment: Alignment.centerLeft, child: icon),
              SizedBox(width: 20.0),
              Text(
                '$title',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0),
              ),
              SizedBox(width: 10.0),
              Icon(Icons.info_outline, color: Colors.grey[500]),
              Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$value',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: textColor),
                    )),
              ),
            ],
          )),
    );
  }
}
