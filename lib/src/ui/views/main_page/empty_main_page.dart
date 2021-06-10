import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shorty/src/theme.dart';
import 'package:shorty/src/ui/shared/logo.dart';
import 'package:shorty/src/ui/shared/responsive_safe_area.dart';
import 'package:shorty/src/util/assets.dart';

class EmptyMainPage extends StatelessWidget {
  const EmptyMainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        Logo(),
        Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              illustration,
              height: mediaQuery.size.height * .45,
            )),
        Text("Let’s get started!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            "Paste your first link into \n the field to shorten it",
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
