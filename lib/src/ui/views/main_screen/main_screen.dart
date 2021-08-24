import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../business_logic/models/view_state.dart';
import '../../../business_logic/view_models/urls_view_model.dart';
import '../../../services/service_locator.dart';
import '../../../themes/app_theme.dart';
import '../../../utils/assets_paths.dart';
import '../../shared/error_dialog.dart';
import '../../shared/loading_dialog.dart';
import '../../shared/responsive_safe_area.dart';
import './empty_main_screen.dart';
import './shorten_link_card.dart';

class MainPage extends StatefulWidget {
  static const String routeName = "/main-page";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.offWhite,
      body: ResponsiveSafeArea(builder: (context, size) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            children: [
              Expanded(
                  child: ChangeNotifierProvider.value(
                value: _urlsViewMode,
                child: Consumer<UrlsViewModel>(
                  builder: (context, model, child) {
                    if (_urlsViewMode.state == ViewState.busy) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (_urlsViewMode.historyLoadingFailure != null) {
                      return HistoryLoadingError();
                    }

                    if (_urlsViewMode.shortUrls.isEmpty) return EmptyMainPage();

                    return ShortUrlsList();
                  },
                ),
              )),
              ShortUrlForm(
                size: size,
              )
            ],
          ),
        );
      }),
    );
  }
}

class ShortUrlForm extends StatefulWidget {
  const ShortUrlForm({Key? key, required this.size}) : super(key: key);
  final Size size;
  @override
  _ShortUrlFormState createState() => _ShortUrlFormState();
}

class _ShortUrlFormState extends State<ShortUrlForm> {
  final _urlTextFieldController = TextEditingController();
  final _urlsViewMode = serviceLocator<UrlsViewModel>();
  bool _showTextFieldErrorMessage = false;

  void _updateTextFiledErrorMessageFlag(bool newValue) {
    setState(() {
      _showTextFieldErrorMessage = newValue;
    });
  }

  Future<void> _shortenUrl(BuildContext context) async {
    loadingDialog("Shorting your url...", context);
    await _urlsViewMode.shortUrl(_urlTextFieldController.text);
    Navigator.of(context).pop();
  }

  void _onShortenPressed() async {
    if (_urlTextFieldController.text.isEmpty) {
      _updateTextFiledErrorMessageFlag(true);
      return;
    } else {
      _updateTextFiledErrorMessageFlag(false);
    }

    await _shortenUrl(context);

    if (_urlsViewMode.mainFailure != null) {
      errorDialog(_urlsViewMode.mainFailure.toString(), context);
    } else {
      FocusManager.instance.primaryFocus?.unfocus();
      _urlTextFieldController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final applocalization = AppLocalizations.of(context);
    final size = widget.size;

    return Container(
      color: AppTheme.darkViolet,
      width: double.infinity,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        children: [
          Positioned(
              right: 0,
              top: 0,
              child: SvgPicture.asset(
                shape,
                height: 100,
              )),
          Center(
            child: Container(
              width: size.width * .85,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  ShortUrlTextField(
                      urlTextFieldController: _urlTextFieldController,
                      showTextFieldErrorMessage: _showTextFieldErrorMessage),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: _onShortenPressed,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(applocalization!.shortenIt.toUpperCase()),
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HistoryLoadingError extends StatelessWidget {
  HistoryLoadingError({Key? key}) : super(key: key);
  final _urlsViewMode = serviceLocator<UrlsViewModel>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _urlsViewMode.historyLoadingFailure.toString(),
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: AppTheme.red, fontSize: 18),
          ),
          const SizedBox(
            height: 6,
          ),
          TextButton(
              onPressed: _urlsViewMode.getShortUrlsHistory,
              child: Text("Try again!"))
        ],
      ),
    );
  }
}

class ShortUrlsList extends StatelessWidget {
  ShortUrlsList({Key? key}) : super(key: key);
  final _urlsViewMode = serviceLocator<UrlsViewModel>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              AppLocalizations.of(context)!.yourLinkHistory,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              final shortUrl = _urlsViewMode.shortUrls[index];
              return ShortenLinkCard(
                  key: ValueKey(shortUrl.code),
                  shortenUrl: shortUrl);
            },
            itemCount: _urlsViewMode.shortUrls.length,
          ),
        )
      ],
    );
  }
}

class ShortUrlTextField extends StatelessWidget {
  const ShortUrlTextField({
    Key? key,
    required TextEditingController urlTextFieldController,
    required bool showTextFieldErrorMessage,
  })  : _urlTextFieldController = urlTextFieldController,
        _showTextFieldErrorMessage = showTextFieldErrorMessage,
        super(key: key);

  final TextEditingController _urlTextFieldController;
  final bool _showTextFieldErrorMessage;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return TextField(
      controller: _urlTextFieldController,
      style: AppTheme.textFieldTextStyle,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          hintText: _showTextFieldErrorMessage
              ? appLocalizations!.pleaseAddALinkHere
              : appLocalizations!.shortenALinkHere,
          hintStyle: _showTextFieldErrorMessage
              ? AppTheme.errorHintStyle
              : AppTheme.hintStyle,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: _showTextFieldErrorMessage
                      ? AppTheme.red
                      : Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: _showTextFieldErrorMessage
                      ? AppTheme.red
                      : Colors.transparent))),
    );
  }
}
