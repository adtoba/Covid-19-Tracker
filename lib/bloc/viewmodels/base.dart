import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

enum OperationStatus {
  LOADING,
  SUCCESSFUL,
  FAILED
}

class BaseViewModel extends ChangeNotifier {
  OperationStatus _status;

  OperationStatus get viewStatus => _status;

  void setStatus(OperationStatus status) {
    _status = status;
    notifyListeners();
  }
  
}