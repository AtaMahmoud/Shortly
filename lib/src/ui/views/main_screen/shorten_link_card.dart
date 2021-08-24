import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../business_logic/models/short_url.dart';
import '../../../business_logic/view_models/urls_view_model.dart';
import '../../../services/service_locator.dart';
import '../../../themes/app_theme.dart';
import '../../../utils/assets_paths.dart';
import '../../../utils/string_overflow_extension.dart';
import '../../shared/error_dialog.dart';

class ShortenLinkCard extends StatefulWidget {
  final ShortUrl shortenUrl;
  const ShortenLinkCard({Key? key, required this.shortenUrl}) : super(key: key);

  @override
  _ShortenLinkCardState createState() => _ShortenLinkCardState();
}

class _ShortenLinkCardState extends State<ShortenLinkCard> {
  bool isCopied = false;
  final _urlsViewModel = serviceLocator<UrlsViewModel>();

  void _onDeletePressed() {
    _urlsViewModel.removeUrlFromHistory(widget.shortenUrl);
    if (_urlsViewModel.mainFailure != null) {
      errorDialog(_urlsViewModel.mainFailure.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
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
                      onTap: _onDeletePressed, child: SvgPicture.asset(delete))
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
                  width: constraints.maxWidth * .80,
                  child: ElevatedButton(
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style!
                          .copyWith(
                            backgroundColor: MaterialStateProperty.all(
                                isCopied ? AppTheme.darkViolet : AppTheme.cyan),
                          ),
                      onPressed: _onCopyPressed,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Text(isCopied
                            ? appLocalizations!.copied.toUpperCase()
                            : appLocalizations!.copy.toUpperCase()),
                      )),
                )),
            SizedBox(
              height: 20,
            )
          ],
        ),
      );
    });
  }

  void _onCopyPressed() {
    setState(() {
      isCopied = true;
    });

    Clipboard.setData(ClipboardData(text: widget.shortenUrl.fullShortLink));

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isCopied = false;
      });
    });
  }
}
