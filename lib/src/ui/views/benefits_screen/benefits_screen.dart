import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../business_logic/view_models/user_view_model.dart';
import '../../../services/service_locator.dart';
import '../../../themes/app_theme.dart';
import '../../../utils/assets_paths.dart';
import '../../shared/logo.dart';
import '../../shared/responsive_safe_area.dart';
import '../main_screen/main_screen.dart';
import './benefits_card.dart';
import './dot_indicator.dart';

class BenefitsScreen extends StatefulWidget {
  static const String routeName = "/benefits";
  const BenefitsScreen({Key? key}) : super(key: key);

  @override
  _BenefitsScreenState createState() => _BenefitsScreenState();
}

class _BenefitsScreenState extends State<BenefitsScreen> {
  final _pageController = PageController();
  int currentIndex = 0;

  void _onSkipNextPressed() {
    Navigator.of(context).pushNamed(MainPage.routeName);
    serviceLocator<UserViewModel>().setDisplayOnBoardingFlag(value: false);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context);
    final cards = <BenefitsCard>[
      BenefitsCard(
          content: appLocalization!.boostYourBrandRecognitionAndBrandedLinks,
          title: appLocalization.brandRecognition,
          assetPath: digram),
      BenefitsCard(
          content: appLocalization.gainInsightsAndEngagementWithContent,
          title: appLocalization.detailedRecords,
          assetPath: gauge),
      BenefitsCard(
          content: appLocalization.improveBrandAwareness,
          title: appLocalization.fullyCustomizable,
          assetPath: tools),
    ];
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: ResponsiveSafeArea(builder: (context, size) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Logo(),
            Column(
              children: [
                Container(
                  height: 220,
                  width: size.width * .9,
                  child: PageView.builder(
                    itemBuilder: (context, index) => cards[index],
                    itemCount: cards.length,
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    clipBehavior: Clip.none,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                DotIndicator(
                    itemCount: cards.length, currentIndex: currentIndex),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextButton(
                    onPressed: _onSkipNextPressed,
                    child: Text(
                      currentIndex == cards.length - 1
                          ? appLocalization.next
                          : appLocalization.skip,
                      style: AppTheme.benifitsTextButtonTextStyle,
                    ))),
          ],
        );
      }),
    );
  }
}
