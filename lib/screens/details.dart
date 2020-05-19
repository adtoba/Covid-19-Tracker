import 'package:covid19/res/size_config.dart';
import 'package:covid19/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsViewScreen extends StatefulWidget {
  const NewsViewScreen({
    @required this.imageUrl,
    @required this.title,
    this.description,
    this.content,
    this.url
  });

  final String imageUrl;
  final String title;
  final String description;
  final String content;
  final String url;

  @override
  _NewsViewScreenState createState() => _NewsViewScreenState();
}

class _NewsViewScreenState extends State<NewsViewScreen> {
  @override
  Widget build(BuildContext context) {
    final SizeConfig config = SizeConfig();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: config.sh(400),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(
                  widget.imageUrl ?? 'https://crowdsourcer.io/assets/images/no-img.png',
                ),
                fit: BoxFit.cover
              ),
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: Colors.grey.withOpacity(0.5),
                    child: Column(
                      children: <Widget>[
                        AppBar(
                          backgroundColor: Colors.transparent,
                          leading: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        ),
                        SizedBox(height: config.sh(30.0)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: config.sw(20.0)),
                          child: Text(
                            widget.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                              style: Theme.of(context).textTheme.display1.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            
          ),

          Positioned(
            top: config.sh(250),
            left: config.sw(20),
            right: config.sw(0),
            bottom: config.sh(0),
            child: Container(
              padding: const EdgeInsets.all(30.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20)
                ),
                color: Colors.white
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(widget.description ?? '', style: const TextStyle(fontSize: 20.0),),
                    SizedBox(height: config.sh(20)),
                    Text(widget.content ?? '', style: const TextStyle(fontSize: 20.0),),
                    SizedBox(height: config.sh(30.0)),
                    InkWell(
                      onTap: () async {
                        if(await canLaunch(widget.url.toString())) {
                          launch(widget.url.toString());
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.link, color: Colors.white),
                            SizedBox(width: config.sw(10)),
                            Text('Read full article', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              )
            ),
          )
        ],
      ),
    );
  }
}