import 'package:covid19/bloc/viewmodels/base.dart';
import 'package:covid19/bloc/viewmodels/faqs.dart';
import 'package:covid19/res/size_config.dart';
import 'package:covid19/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FaqScreen extends StatefulWidget {
  const FaqScreen({Key key}) : super(key: key);

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {

  FaqsViewModel faqsViewModel;

  @override
  void didChangeDependencies() {
    final faqsModel = Provider.of<FaqsViewModel>(context);

    if(faqsViewModel != faqsModel) {
      faqsViewModel = faqsModel;
      Future<void>.microtask(() {
        faqsModel.getFaqs();
      });
    }
    
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final SizeConfig config = SizeConfig();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text('Frequently Asked Questions', style: TextStyle(color: Colors.black),),
      ),
      body: Container(
        child: Consumer<FaqsViewModel>(
          builder: (BuildContext context, FaqsViewModel model, _) {
            if(model.opStatus == OperationStatus.LOADING) {
              return const Center(
                child: Loader(),
              );
            } else {
              return ListView.builder(
                itemCount: model.faqsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                    title: Text(model.faqsList[index].question, style: TextStyle(fontSize: config.sp(25.0)),),
                    subtitle: Text(model.faqsList[index].answer, style: TextStyle(fontSize: config.sp(16)),),
                    initiallyExpanded: false,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                             
                            }, 
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.link),
                                const SizedBox(width: 10.0),
                                const Text('Read more')
                              ],
                            )
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            }
          },
        )
      )
    );
  }
}