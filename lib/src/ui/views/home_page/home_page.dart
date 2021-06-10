import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../util/assets.dart';
import '../../shared/responsive_safe_area.dart';
import 'package:shorty/src/ui/views/on_boarding_screens/on_boarding_screens.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ResponsiveSafeArea(
        builder: (context, size) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              SvgPicture.asset(logo),
              Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(illustration)),
              Text("More than just \n shorter links",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline1),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Build your brand’s recognition and get detailed insights on how your links are performing.",
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                  width: size.width * .8,
                  height: size.height * .07,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OnBoardingScreens()));
                    },
                    child: Text("START"),
                  ))
            ],
          );
        },
      ),
    );
  }
}
