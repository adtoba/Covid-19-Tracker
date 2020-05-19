import 'package:covid19/bloc/viewmodels/base.dart';
import 'package:covid19/bloc/viewmodels/news.dart';
import 'package:covid19/res/size_config.dart';
import 'package:covid19/screens/details.dart';
import 'package:covid19/utils/navigation.dart';
import 'package:covid19/widgets/news_item.dart';
import 'package:flutter/material.dart';
import 'package:covid19/utils/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';



class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  NewsViewModel newsViewModel;
  DateTime dateTime;
  String date;
  int _currentPage = 1;

  @override
  void didChangeDependencies() {
    final NewsViewModel newsModel = Provider.of<NewsViewModel>(context);

    if(newsViewModel != newsModel) {
      newsViewModel = newsModel;
      dateTime = DateTime.now();
      date = dateTime.year.toString() + 
        '-' + dateTime.month.toString() 
            + '-' + dateTime.day.toString();

      Future<void>.microtask(() { 
        newsViewModel.newsUpdates(date, _currentPage.toString());
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final SizeConfig config = SizeConfig();
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            stretch: true,
            stretchTriggerOffset: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle
              ],
             background: Stack( fit: StackFit.expand,
                children: <Widget>[
                  Consumer<NewsViewModel>(
                    builder: (BuildContext context, NewsViewModel model, _) {
                      if(model.newsStatus == OperationStatus.LOADING) {
                        return const SpinKitChasingDots(
                          color: MkColors.rectangleColor,
                          size: 30,
                        );
                      } else if(model.newsStatus == OperationStatus.FAILED) {
                        return Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/no-image.png')
                            )
                          ),
                          
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: model.newsList.isNotEmpty ? NetworkImage(model.newsList[0].urlImage ?? model.newsList[1].urlImage) : AssetImage('assets/images/no-image.png')
                            )
                          ),
                          
                        );
                      }        
                    },                 
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: <Widget>[
                        Visibility(
                          visible: newsViewModel.newsStatus == OperationStatus.SUCCESSFUL,
                          child: Container(
                            color: Colors.grey.withOpacity(0.4),
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: const Text(
                                    'Highlights', style: TextStyle(color:Colors.white),
                                  ),
                                  decoration: const BoxDecoration(
                                    color: MkColors.rectangleColor
                                  ),
                                ),
                                Text(
                                  newsViewModel.newsList == null
                                    ? ''
                                    : newsViewModel.newsList[0].urlImage == null && newsViewModel.newsList.isNotEmpty 
                                    ? newsViewModel.newsList[1].title     
                                    : newsViewModel.newsList[0].title,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.display1.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            )
          ),

          SliverToBoxAdapter(          
           child: Container(
             decoration: const BoxDecoration(
               color: Color(0xFFf2f6f8),
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(20), 
                 topRight: Radius.circular(20)
              )
             ),
             
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                  Padding(
                   padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20.0, bottom: 0),
                   child: Visibility(
                     visible: newsViewModel.newsStatus == OperationStatus.SUCCESSFUL,
                     child: const Text(
                       'Related news', style: TextStyle(fontSize: 20.0),
                     ),
                   ),
                 ),

                 Consumer<NewsViewModel>(
                   builder: (BuildContext context, NewsViewModel model, _) {
                     if(model.newsStatus == OperationStatus.LOADING) {
                       return const SpinKitChasingDots(
                         color: MkColors.rectangleColor,
                         size: 30,
                       );
                     } else if(model.newsStatus == OperationStatus.SUCCESSFUL) {
                        return Column(
                         children: <Widget>[
                           newsViewModel.newsList.isEmpty 
                            ? const Text('No news at the moment')
                            : ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: newsViewModel?.newsList?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return NewsItem(
                                imageUrl: newsViewModel.newsList[index].urlImage, 
                                title: newsViewModel.newsList[index].title, 
                                subtitle: newsViewModel.newsList[index].description,
                                publishedAt: newsViewModel.newsList[index].publishedAt.replaceAll('T', " ").replaceAll('Z', ''),
                                onPressed: () => push(context, NewsViewScreen(
                                  imageUrl: newsViewModel.newsList[index].urlImage,
                                  title: newsViewModel.newsList[index].title,
                                  content: newsViewModel.newsList[index].content,
                                  description: newsViewModel.newsList[index].description,
                                  url: newsViewModel.newsList[index].url,
                                ))
                              );
                            },
                          ),

                          FlatButton(
                            onPressed: () {
                              _currentPage = _currentPage + 1;
                              if(_currentPage >= 9) {
                                _currentPage = 1;
                              }
                              newsViewModel.newsUpdates(date, _currentPage.toString());
                            }, 
                            child: const Text(
                              'Read more ....'
                            )
                          ),
                          SizedBox(height: config.sh(50.0))
                         ],
                       );
                       
                     } else {
                        return Center(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             Icon(Icons.info_outline, size: 100, color: Colors.grey),
                             SizedBox(height: config.sh(10)),
                             const Text('Unable to fetch news', style: TextStyle(fontSize: 18.0, color: Colors.grey),),
                             SizedBox(height: config.sh(10)),
                           ],
                         ),
                       );
                     }
                   },
                 )
               ],
             ),
           ),
         )
        ],
        
      ),
    );
  }
}
