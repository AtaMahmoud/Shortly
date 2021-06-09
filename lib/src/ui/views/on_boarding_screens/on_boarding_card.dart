import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme.dart';

class OnBoardingCard extends StatelessWidget {
  final String title;
  final String content;
  final String assetPath;
  const OnBoardingCard(
      {Key? key,
      required this.content,
      required this.title,
      required this.assetPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * .5,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Container(
              width: mediaQuery.size.width * .85,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      content,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: -30,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppTheme.darkViolet,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                assetPath,
                width: 40,
                height: 40,
              ),
            ),
          )
        ],
      ),
    );
  }
}
