import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/assets_paths.dart';
import '../../shared/logo.dart';

class EmptyMainPage extends StatelessWidget {
  const EmptyMainPage({
    Key? key,
  }) : super(key: key);

  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide > 600;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Logo(),
            Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  illustration,
                  height: constraints.maxHeight * .6,
                )),
            if (isTablet(context))
              SizedBox(
                height: MediaQuery.of(context).size.height*.05,
              ),
            Column(
              children: [
                Container(
                  width: constraints.maxWidth * .6,
                  child: AutoSizeText(appLocalization!.letsGetStarted,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline1),
                ),
                Container(
                  width: constraints.maxWidth * .6,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: AutoSizeText(
                    appLocalization.pastYourFirstLink,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
