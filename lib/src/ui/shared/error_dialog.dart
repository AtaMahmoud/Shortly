import 'package:flutter/material.dart';

/// Display Dialog with [errorMessage] as an error message
void errorDialog(String errorMessage, BuildContext context) {
  final textTheme = Theme.of(context).textTheme;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(
            "Something went wrong",
            style: textTheme.headline2,
          ),
          content: Text(
            errorMessage,
            style: textTheme.bodyText1,
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Ok",
                  style: textTheme.bodyText1!
                      .copyWith(color: Colors.black, fontSize: 14),
                ))
          ],
        );
      });
}
