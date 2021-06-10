import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:shorty/src/theme.dart';
import 'package:shorty/src/ui/shared/logo.dart';
import 'package:shorty/src/ui/shared/responsive_safe_area.dart';
import 'package:shorty/src/util/assets.dart';

import 'empty_main_page.dart';
import '../../../util/overflow_extension.dart';
import 'shorten_link_card.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: ResponsiveSafeArea(builder: (context, size) {
        return Column(
          children: [
            Expanded(
                child: Column(
              children: [ShortenLinkCard()],
            )),
            Container(
              color: AppTheme.darkViolet,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(right: 0, top: 0, child: SvgPicture.asset(shape)),
                  Center(
                    child: Container(
                      width: size.width * .85,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Column(
                        children: [
                          Container(
                            height: size.height * .08,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6)),
                            child: TextField(
                              style: AppTheme.textFieldTextStyle,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "Shorten a link here ...",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: size.height * .08,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {}, child: Text("SHORTEN IT!")),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}

