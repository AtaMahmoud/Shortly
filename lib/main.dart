import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/business_logic/models/short_url.dart';
import 'src/business_logic/view_models/user_view_model.dart';
import 'src/services/service_locator.dart';
import 'src/themes/app_theme.dart';
import 'src/ui/views/benefits_screen/benefits_screen.dart';
import 'src/ui/views/main_screen/main_screen.dart';
import 'src/ui/views/start_screen.dart';
import 'src/utils/constants.dart';

void main() async {
  setupServiceLocator();
  await initHive();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ShortUrlAdapter());
  await Hive.openBox<ShortUrl>(urlsBoxName);
  await Hive.openBox(userSettingsBoxName);
}

void disposeHive() {
  Hive.box<ShortUrl>(urlsBoxName).compact();
  Hive.box(userSettingsBoxName).compact();
  Hive.close();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _userViewModel = serviceLocator<UserViewModel>();

  @override
  void initState() {
    _userViewModel.getDisplayOnBoardingFlag();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale("en"),
          const Locale("de"),
        ],
        theme: AppTheme().theme,
        routes: {
          StartScreen.routeName: (context) =>
              _userViewModel.shouldDisplayOnBoardingScreens
                  ? StartScreen()
                  : MainPage(),
          BenefitsScreen.routeName: (context) => BenefitsScreen(),
          MainPage.routeName: (context) => MainPage()
        });
  }

  @override
  void dispose() {
    disposeHive();
    super.dispose();
  }
}
