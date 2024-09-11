import 'package:flutter/material.dart';

import 'page_number_provider.dart';

class NumberPageContainer extends InheritedWidget {
  const NumberPageContainer(
      {super.key, required this.pageService, required super.child});
  final NumberPageService pageService;

  @override
  bool updateShouldNotify(covariant NumberPageContainer oldWidget) {
    return oldWidget.pageService != pageService;
  }

  static NumberPageService of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NumberPageContainer>()!
        .pageService;
  }
}
