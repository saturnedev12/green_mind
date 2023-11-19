import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialog {
  static info(
          {required BuildContext context,
          required String content,
          required Widget icon}) =>
      showCupertinoModalPopup(
        barrierDismissible: false,
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: icon,
          content: Text(
            content,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: false,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  static void confirmDialog(
      {required BuildContext context,
      required String message,
      required void Function() onConfirm,
      Widget? title}) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          title: title,
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              onPressed: onConfirm,
              child: Text(
                "Confirmer",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            /*CupertinoDialogAction(
            child: Text("NO"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )*/
          ],
        );
      },
    );
  }
}
