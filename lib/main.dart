import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/theme.dart';
import 'src/ui/views/home_page/home_page.dart';

// ignore_for_file: public_member_api_docs
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shorty',
      theme: AppTheme().theme,
      home: HomePage(),
    );
  }
}

