import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/assets_paths.dart';
import '../shared/logo.dart';
import '../shared/responsive_safe_area.dart';
import './benefits_screen/benefits_screen.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = "/";
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ResponsiveSafeArea(
        builder: (context, size) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Logo(),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    illustration,
                    width: size.width,
                    height: size.height * .44,
                  )),
              Column(
                children: [
                  Container(
                    width: size.width * .65,
                    child: AutoSizeText(
                      appLocalizations!.moreThanJustShorterLinks,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: size.width * .80,
                    child: AutoSizeText(
                        appLocalizations.brandRecognitionAndDetailsInsights,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                        maxLines: 3),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: size.width * .8,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(BenefitsScreen.routeName),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(appLocalizations.start)),
                  )),
              SizedBox(
                height: 6,
              ),
            ],
          );
        },
      ),
    );
  }
}
