import 'package:covid19/res/size_config.dart';
import 'package:covid19/utils/chart.dart';
import 'package:covid19/utils/colors.dart';
import 'package:covid19/widgets/chart.dart';
import 'package:flutter/material.dart';

class DetailBox extends StatelessWidget {
  const DetailBox({
    Key key,
    @required this.label,
    @required this.value,
    @required this.isDeath,
  }) : super(key: key);

  final String label;
  final int value;
  final bool isDeath;

  @override
  Widget build(BuildContext context) {
    final SizeConfig config = SizeConfig();
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: config.sw(15.0), vertical: config.sh(15)),
        width: config.sh(170),
        constraints: BoxConstraints(
          minHeight: config.sh(150),
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20.0))),
                builder: (BuildContext context) {
                  return Container(
                    height: 100.0,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          top: 20.0,
                          left: 30,
                          right: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                isDeath ? 'Total deaths' : 'Total recovered',
                                style: TextStyle(fontSize: config.sp(20.0)),
                              ),
                              SizedBox(height: config.sh(10)),
                              Text(
                                value.toString().replaceAllMapped(reg, mathFunc),
                                style: TextStyle(
                                    fontSize: config.sp(40.0),
                                    color: isDeath
                                        ? MkColors.rectangleColor
                                        : MkColors.greenColor),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: -30,
                          right: 20,
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.close,
                                color: isDeath
                                    ? MkColors.rectangleColor
                                    : MkColors.greenColor),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                  );
                });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label,
                  style: TextStyle(
                      color: MkColors.labelColor, fontSize: config.sp(14))),
              SizedBox(height: config.sh(5.0)),

              TweenAnimationBuilder<int>(
                  tween: IntTween(begin: 0, end: value ),
                  duration: const Duration(seconds: 2),
                  builder: (BuildContext context, int i, Widget child) {
                    return Text(
                      i.toString().replaceAllMapped(reg, mathFunc),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: isDeath
                              ? MkColors.rectangleColor
                              : MkColors.greenColor,
                          fontSize: config.sp(35)),
                    );
                  }),

              SizedBox(height: config.sh(5.0)),

              Center(
                  child: Image.asset(
                'assets/images/candle-chart.png',
                height: 50.0,
                width: 50.0,
                color: isDeath ? MkColors.rectangleColor : MkColors.greenColor,
              )),
              // ChartDisplay(
              //   chartColor: isDeath ? MkColors.rectangleColor : MkColors.greenColor
              // ),
              SizedBox(height: config.sh(10.0)),
              Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: MkColors.iconColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
