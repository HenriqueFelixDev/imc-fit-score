import 'package:flutter/material.dart';

import 'page_indicator.dart';

class PageIndicatorsBar extends StatelessWidget {
  final int pages;
  final int currentPage;

  const PageIndicatorsBar({
    super.key,
    required this.pages,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages,
        (index) => PageIndicator(isActive: currentPage == index),
      ),
    );
  }
}
