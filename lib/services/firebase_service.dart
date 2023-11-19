import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenmind/utils/app_dialog.dart';

class FireBaseService {
  BuildContext context;
  FirebaseAuth auth = FirebaseAuth.instance;
  FireBaseService({required this.context});
  listenUser() {
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        context.replace('/login');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future checkPhone({required String phone}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        log("Verification complete");
        auth
            .signInWithCredential(credential)
            .then((value) => context.replace('/home'))
            .onError(
              (error, stackTrace) => AppDialog.info(
                  context: context,
                  icon: Icon(Icons.info_outline),
                  content: error.toString()),
            );
      },
      verificationFailed: (FirebaseAuthException e) {
        log("Verification Failed");
        AppDialog.info(
            context: context, icon: Icon(Icons.info_outline), content: e.code);
      },
      codeSent: (String verificationId, int? resendToken) {
        log("Verification code send");
        context.go('/otp/$verificationId');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log("Verification code timeOut ");
        AppDialog.info(
            context: context,
            icon: Icon(Icons.info_outline),
            content: "Verification code timeOut ");
      },
    );
  }

  bool userExiste() {
    User? user = auth.currentUser;

    if (user != null) {
      print('User is logged in');
      return true;
    }
    print('User is not logged in');
    return false;
  }
}
