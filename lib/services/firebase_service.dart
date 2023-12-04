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
              (error, stackTrace) => print('test'),
            );
      },
      verificationFailed: (FirebaseAuthException e) {
        print('ici');
        print(e.message);
        log(e.message.toString());
        AppDialog.info(
            context: context, icon: Icon(Icons.info_outline), content: e.message.toString());
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
