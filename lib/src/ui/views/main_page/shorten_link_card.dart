import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shorty/src/business_logic/models/shorten_url.dart';
import 'package:shorty/src/business_logic/view_models/urls_view_model.dart';
import 'package:shorty/src/services/service_locator.dart';

import '../../../theme.dart';
import '../../../util/overflow_extension.dart';
import 'package:shorty/src/util/assets.dart';

class ShortenLinkCard extends StatefulWidget {
  final ShortenUrl shortenUrl;
  const ShortenLinkCard({Key? key, required this.shortenUrl}) : super(key: key);

  @override
  _ShortenLinkCardState createState() => _ShortenLinkCardState();
}

class _ShortenLinkCardState extends State<ShortenLinkCard> {
  bool isCopied = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      shadowColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.shortenUrl.originalLink.overflow,
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                GestureDetector(
                    onTap: () {
                      serviceLocator<UrlsViewModel>()
                          .removeUrlFromHistory(widget.shortenUrl);
                    },
                    child: SvgPicture.asset(delete))
              ],
            ),
          ),
          Divider(
            color: AppTheme.lightGray,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              widget.shortenUrl.fullShortLink,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: AppTheme.cyan),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.center,
              child: Container(
                width: mediaQuery.size.width * .85,
                height: mediaQuery.size.height * .075,
                child: ElevatedButton(
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style!
                        .copyWith(
                          backgroundColor: MaterialStateProperty.all(
                              isCopied ? AppTheme.darkViolet : AppTheme.cyan),
                        ),
                    onPressed: () {
                      setState(() {
                        isCopied = true;
                      });

                      Clipboard.setData(
                          ClipboardData(text: widget.shortenUrl.fullShortLink));

                      Future.delayed(Duration(seconds: 3), () {
                        setState(() {
                          isCopied = false;
                        });
                      });
                    },
                    child: Text(isCopied ? "COPIED!" : "COPY")),
              )),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
