import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../themes/app_theme.dart';

class BenefitsCard extends StatelessWidget {
  final String title;
  final String content;
  final String assetPath;
  const BenefitsCard(
      {Key? key,
      required this.content,
      required this.title,
      required this.assetPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 10, left: 10, right: 10),
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
                    height: 20,
                  ),
                  Container(
                    width: constraints.maxWidth * .85,
                    child: AutoSizeText(
                      content,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                      maxLines: 4,
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
      );
    });
  }
}
