import 'package:covid19/bloc/viewmodels/base.dart';
import 'package:covid19/models/faqs.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class FaqsViewModel extends ChangeNotifier {

  OperationStatus _opStatus;
  String _message;

  OperationStatus get opStatus => _opStatus;
  String get message => _message;

  List<FAQS> _faqsList;
  List<FAQS> get faqsList => _faqsList; 

  final String url = 'http://covid19-news.herokuapp.com/api/covid19/faqs';


  Dio dio = Dio();

  void _gettingFAQS() {
    _opStatus = OperationStatus.LOADING;
    notifyListeners();
  }

  void _getFAQSFailed({String errorMessage: 'Failed to get FAQS'}) {
    _opStatus = OperationStatus.FAILED;
    _message = errorMessage;
    notifyListeners();
  }

  void _getFAQSSuccessful() {
    _opStatus = OperationStatus.SUCCESSFUL;
    notifyListeners();
  }

  void resetGetFAQS() {
    _opStatus = null;
    _message = null;
    notifyListeners();
  }

  Future<void> getFaqs() async {
    _gettingFAQS(); 
    Response _response;

    try {
      _response = await dio.get(url);
      final List<dynamic> _tempList = _response.data['data'];

      _faqsList = List<FAQS>.from(_tempList.map((dynamic item) => FAQS.fromJson(item)));

      print(_response.statusCode.toString());
      print(_response.statusMessage);
      
      if(_response.statusCode == 200) {
        _getFAQSSuccessful();
      } else {
        _getFAQSFailed();
      }

    } on DioError catch (e) {
      _getFAQSFailed(errorMessage: e.toString());
    }
  }




}