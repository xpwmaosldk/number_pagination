import 'package:flutter/material.dart';

class NumberPageService with ChangeNotifier {
  int _currentPage = -1;
  int _previousPage = -1;

  NumberPageService(this._currentPage);

  set currentPage(int n) {
    _previousPage = _currentPage;
    _currentPage = n;
    notifyListeners();
  }

  int get currentPage => _currentPage;
  int get previousPage => _previousPage;
}
