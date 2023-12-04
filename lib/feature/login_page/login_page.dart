import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:greenmind/configs/constants.dart';
import 'package:greenmind/cubit/app_states/app_state.dart';
import 'package:greenmind/cubit/login_cubit.dart';
import 'package:greenmind/utils/form_controller.dart';
import 'package:greenmind/utils/form_utils.dart';
import 'package:greenmind/widgets/custom_button.dart';
import 'package:greenmind/widgets/custom_loading_button.dart';
import 'package:greenmind/widgets/custom_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late ValueNotifier<bool> _passwordNotifier;
  late GlobalKey<FormState> _formKey;

  late Map<String, dynamic> _formData;
  late FormController _formController;

  // INITSTATE
  @override
  void initState() {
    // TODO: implement initState
    _formController = FormController(
      productId: 0,
      // email: TextEditingController(text: ''),
      phoneNumber: TextEditingController(text: ''),
    );
    _passwordNotifier = ValueNotifier<bool>(false);
    _formKey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.question_circle_fill,
                  color: Colors.black,
                ))
          ],
        ),
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(left: 25, right: 25),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SvgPicture.asset(
                    //   'assets/icons/logo_immo.svg',
                    //   color: HexColor.fromHex('#2072ca'),
                    //   width: 100,
                    // ),
                    Image.asset(
                      "assets/images/logo.png",
                      height: 150,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'veuillez renseigner votre numéro de téléphone avant de commencer.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    // CustomTextField(
                    //   controller: _formController.email,
                    //   labelText: 'Email',
                    //   textInputType: TextInputType.emailAddress,
                    //   prefixIcon: Icon(
                    //     CupertinoIcons.mail,
                    //     size: 19,
                    //   ),
                    //   validator: (value) =>
                    //       FormUtils.emailValidator(email: value),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // ValueListenableBuilder<bool>(
                    //     valueListenable: _passwordNotifier,
                    //     builder: (BuildContext context, bool value, child) {
                    //       return CustomTextField(
                    //         controller: _formController.password,
                    //         obscureText: !_passwordNotifier.value,
                    //         prefixIcon: Icon(CupertinoIcons.lock),
                    //         sufixIcon: IconButton(
                    //           onPressed: () {
                    //             _passwordNotifier.value =
                    //                 !_passwordNotifier.value;
                    //           },
                    //           icon: Icon(
                    //             (value)
                    //                 ? Icons.visibility_off_rounded
                    //                 : Icons.visibility_rounded,
                    //           ),
                    //           iconSize: 22,
                    //         ),
                    //         labelText: 'Mot de passe',
                    //         validator: (value) =>
                    //             FormUtils.passwordValidator(password: value),
                    //       );
                    //     }),
                    CustomTextField(
                      controller: _formController.phoneNumber,
                      textInputType: TextInputType.number,
                      labelText: 'Numéro de téléphone',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(top: 8.5, left: 5),
                        child: const Text(
                          '+225 ',
                          style: TextStyle(fontSize: 22, color: Colors.grey),
                        ),
                      ),
                      sufixIcon: const Icon(CupertinoIcons.phone),
                      validator: (String? value) =>
                          FormUtils.numberValidator(number: value),
                      inputFormatters: [
                        MaskTextInputFormatter(
                            mask: '## ## ## ## ##',
                            filter: {'#': RegExp(r'[0-9]')})
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    BlocBuilder<LoginCubit, AppState>(
                      builder: (context, state) {
                        return CustomLoadingButtom(
                          isLoading: (state is PendingState),
                          color: Theme.of(context).colorScheme.primary,
                          textColor: Colors.white,
                          onClick: ((state is PendingState))
                              ? null
                              : () {
                                
                                  if (_formKey.currentState!.validate()) {
                                    print("object");
                                    
                                    // context.go('/otp');
                                    context.read<LoginCubit>().onLogin(
                                        formController: _formController,
                                        context: context);
                                  }

                                  //context.go('/homePage');
                                },
                          text: 'Obtenir le code',
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: const SizedBox(
            height: 50,
            child: Center(
              child: Text(
                '©GREENMIND•2023',
                style: TextStyle(color: Color.fromARGB(255, 182, 181, 181)),
              ),
            )),
      ),
    );
  }
}
