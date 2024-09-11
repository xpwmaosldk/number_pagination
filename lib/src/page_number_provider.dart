import 'package:flutter/material.dart';

class NumberPageService with ChangeNotifier {

  NumberPageService(this._currentPage);
  int _currentPage = -1;
  int _previousPage = -1;

  set currentPage(int n) {
    _previousPage = _currentPage;
    _currentPage = n;
    notifyListeners();
  }

  int get currentPage => _currentPage;
  int get previousPage => _previousPage;
}
