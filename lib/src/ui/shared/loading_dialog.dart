import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

/// Display Dialog with [loadingText] as an loading text message
void loadingDialog(String loadingText, BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Row(
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppTheme.cyan),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  loadingText,
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
          ),
        );
      });
}
