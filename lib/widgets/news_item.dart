import 'package:covid19/res/size_config.dart';
import 'package:covid19/utils/colors.dart';
import 'package:flutter/material.dart';

class NewsItem extends StatelessWidget {
  const NewsItem(
      {@required this.imageUrl,
      @required this.title,
      @required this.subtitle,
      this.publishedAt,
      this.onPressed});
      

  final String imageUrl;
  final String title;
  final String subtitle;
  final Function onPressed;
  final String publishedAt;

  @override
  Widget build(BuildContext context) {
    final SizeConfig config = SizeConfig();

    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(top: 0.0, bottom: 10, right: 20, left: 20),
        child: Container(
          height: config.sh(120),
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                            image: NetworkImage(
                              '$imageUrl',
                            ),
                            fit: BoxFit.cover)),
                  )),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          '$title',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Expanded(
                        flex: 2,
                        child: Text('$subtitle',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(height: 10.0),
                      Expanded(
                        flex: 1,
                        child: Text('$publishedAt',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w500)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
