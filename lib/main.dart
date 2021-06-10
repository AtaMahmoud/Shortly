import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shorty/src/services/service_locator.dart';
import 'package:shorty/src/util/constants.dart';

import 'src/theme.dart';
import 'src/ui/views/home_page/home_page.dart';

// ignore_for_file: public_member_api_docs
void main() async {
  setupServiceLocator();
  await initHive();
  runApp(MyApp());
}

Future<void> initHive() async {
  await Hive.initFlutter();
  await Hive.openBox(boxName);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        HomePage.routeName: (context) => HomePage(),
      },
    );
  }
}
