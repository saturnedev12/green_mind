import 'dart:math';

import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenmind/widgets/custom_text_field.dart';

class FormUtils {
  static void showAlertConfirmDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Proceed with destructive action?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  static String? emailValidator({String? email}) {
    if (email == null || email.isEmpty) {
      return 'Aucune adresse mail';
    } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      caseSensitive: false,
      multiLine: false,
    ).hasMatch(email)) {
      return 'Adresse non valide';
    }
    return null;
  }

  static String? passwordValidator({String? password}) {
    if (password == null || password.isEmpty) {
      return 'Aucun mot de passe';
    } else if (!RegExp(r'^.{4,}$').hasMatch(password)) {
      return 'Mot de passe trop court';
    }
    return null;
  }

  static String? fieldValidator({String? value}) {
    if (value == null || value.isEmpty) {
      return 'veillez entrer votre nom';
    }
    return null;
  }

  static String? numberValidator({String? number}) {
    if (number == null || number.isEmpty || number.toString().isEmpty) {
      return 'veillez entrer votre numéro';
    }

    return null;
  }
}
