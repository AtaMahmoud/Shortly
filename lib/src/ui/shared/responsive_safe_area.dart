import 'dart:io';

import 'package:flutter/material.dart';

// ignore: public_member_api_docs
typedef ResponsiveBuilder = Widget Function(
  BuildContext context,
  Size size,
);

class ResponsiveSafeArea extends StatelessWidget {
  // ignore: public_member_api_docs
  const ResponsiveSafeArea({
    required ResponsiveBuilder builder,
    Key? key,
  })  : responsiveBuilder = builder,
        super(key: key);

  final ResponsiveBuilder responsiveBuilder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: !Platform.isIOS,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return responsiveBuilder(
            context,
            constraints.biggest,
          );
        },
      ),
    );
  }
}