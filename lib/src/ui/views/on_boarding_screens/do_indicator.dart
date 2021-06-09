import 'package:flutter/material.dart';
import 'package:shorty/src/theme.dart';

class DotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  const DotIndicator(
      {Key? key, required this.itemCount, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
        itemCount,
        (index) => Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              color: currentIndex == index ? AppTheme.gray : Colors.transparent,
              border: Border.all(color: AppTheme.gray, width: 2),
              shape: BoxShape.circle),
        ),
      )),
    );
    ;
  }
}
