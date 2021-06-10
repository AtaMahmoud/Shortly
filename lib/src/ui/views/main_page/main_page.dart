import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shorty/src/business_logic/models/view_state.dart';
import 'package:shorty/src/business_logic/view_models/urls_view_model.dart';
import 'package:shorty/src/services/service_locator.dart';

import 'package:shorty/src/theme.dart';
import 'package:shorty/src/ui/shared/logo.dart';
import 'package:shorty/src/ui/shared/responsive_safe_area.dart';
import 'package:shorty/src/util/assets.dart';

import 'empty_main_page.dart';
import '../../../util/overflow_extension.dart';
import 'shorten_link_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _urlsViewMode = serviceLocator<UrlsViewModel>();
  @override
  void initState() {
    _urlsViewMode.getShortUrlsHistory();
    super.initState();
  }

  final _urlTextFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: ResponsiveSafeArea(builder: (context, size) {
        return Column(
          children: [
            Expanded(
                child: ChangeNotifierProvider.value(
              value: _urlsViewMode,
              child: Consumer<UrlsViewModel>(
                builder: (context, model, child) {
                  if (_urlsViewMode.state == ViewState.busy) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (_urlsViewMode.shortenUrls.isEmpty) {
                    return EmptyMainPage();
                  }

                  return Column(
                    children: [ShortenLinkCard()],
                  );
                },
              ),
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
                              controller: _urlTextFieldController,
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
                                onPressed: () {
                                  _urlsViewMode
                                      .shortUrl(_urlTextFieldController.text);
                                },
                                child: Text("SHORTEN IT!")),
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
