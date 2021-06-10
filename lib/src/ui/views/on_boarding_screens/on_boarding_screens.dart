import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shorty/src/business_logic/view_models/user_view_model.dart';
import 'package:shorty/src/services/service_locator.dart';
import 'package:shorty/src/ui/views/main_page/main_page.dart';
import 'package:shorty/src/ui/views/on_boarding_screens/do_indicator.dart';
import 'package:shorty/src/ui/views/on_boarding_screens/on_boarding_card.dart';

import '../../../theme.dart';
import '../../../util/assets.dart';
import '../../shared/responsive_safe_area.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({Key? key}) : super(key: key);

  @override
  _OnBoardingScreensState createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  final _pageController = PageController();
  int currentIndex = 0;
  final List<OnBoardingCard> cards = [
    const OnBoardingCard(
        content:
            "Boost your brand recognition with each click. Generic links don’t mean a thing. Branded links help instil confidence in your content.",
        title: "Brand Recognition",
        assetPath: digram),
    const OnBoardingCard(
        content:
            "Gain insights into who is clicking your links. Knowing when and where people engage with your content helps inform better decisions.",
        title: "Detailed Records",
        assetPath: gauge),
    const OnBoardingCard(
        content:
            "lmprove brand awareness and content discoverability through customizable links, supercharglng audience engagement.",
        title: "Fully Customizable",
        assetPath: tools),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: ResponsiveSafeArea(builder: (context, size) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SvgPicture.asset(logo),
            ),
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .4,
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
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MainPage()));
                      serviceLocator<UserViewModel>()
                          .setDisplayOnBoardingFlag(value: false);
                    },
                    child: Text(
                        currentIndex == cards.length - 1 ? "Next" : "Skip"))),
          ],
        );
      }),
    );
  }
}
