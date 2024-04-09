import 'package:flutter/material.dart';

class PageNumberProvider with ChangeNotifier {
  int _currentPageNumber = -1;
  int _previousPageNumber = -1;

  PageNumberProvider(this._currentPageNumber);

  set currentPageNumber(int n) {
    _previousPageNumber = _currentPageNumber;
    _currentPageNumber = n;
    notifyListeners();
  }

  int get currentPageNumber => _currentPageNumber;
  int get previousPageNumber => _previousPageNumber;
}
