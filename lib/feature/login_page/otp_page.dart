import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenmind/utils/app_dialog.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:go_router/go_router.dart';

class OtpPage extends StatefulWidget {
  OtpPage({Key? key, required this.verificationId}) : super(key: key);
  final String verificationId;

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  OtpFieldController otpController = OtpFieldController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
        child: Icon(Icons.replay),
        onPressed: () {
          print("Floating button was pressed.");
          otpController.clear();
          // otpController.set(['2', '3', '5', '5', '7']);
          // otpController.setValue('3', 0);
          // otpController.setFocus(1);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 180,
            ),
            SizedBox(
              height: 15,
            ),
            const Text(
              'veuillez renseigner le code envoyé au +225 07...45',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            SizedBox(
              height: 15,
            ),
            OTPTextField(
                controller: otpController,
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 45,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                otpFieldStyle: OtpFieldStyle(
                  backgroundColor: CupertinoColors.systemFill,
                  borderColor: Colors.transparent,
                  enabledBorderColor: Colors.transparent,
                  disabledBorderColor: Colors.transparent,
                  focusBorderColor: Theme.of(context).colorScheme.primary,
                ),
                style: TextStyle(fontSize: 17),
                onChanged: (pin) {
                  print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  print("Completed: " + pin);
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId, smsCode: pin);
                  auth
                      .signInWithCredential(credential)
                      .then((value) => context.replace('/home'))
                      .onError(
                        (error, stackTrace) => AppDialog.info(
                            context: context,
                            icon: Icon(Icons.info_outline),
                            content: error.toString()),
                      );
                }),
          ],
        ),
      ),
    );
  }
}
