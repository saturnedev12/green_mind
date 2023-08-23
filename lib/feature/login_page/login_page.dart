import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../configs/constants.dart';
import '../../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late ValueNotifier<bool> _passwordNotifier;
  late GlobalKey<FormState> _formKey;

  late Map<String, dynamic> _formData;
  @override
  void initState() {
    // TODO: implement initState
    _passwordNotifier = ValueNotifier<bool>(false);
    _formKey = GlobalKey<FormState>();

    _formData = {"username": "", "password": ""};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   automaticallyImplyLeading: false,

      //   actions: [
      //     IconButton(
      //         onPressed: () {},
      //         icon: Icon(
      //           CupertinoIcons.question_circle_fill,
      //           color: Colors.black,
      //         ))
      //   ],
      // ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.9,
            filterQuality: FilterQuality.high,
            image: AssetImage('assets/images/walpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
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
                SizedBox(
                  height: 15,
                ),
                const Text(
                  'Vous trouverez ce qu\'il vous faut chez nous.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(
                  height: 80,
                ),
                CustomTextField(
                  labelText: 'Email',
                  textInputType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    CupertinoIcons.mail,
                    size: 19,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'veillez entrer votre email';
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return 'Email non valide';
                    }
                    _formData['username'] = value;
                    return null;
                  },
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: _passwordNotifier,
                    builder: (BuildContext context, bool value, child) {
                      return CustomTextField(
                        obscureText: !_passwordNotifier.value,
                        prefixIcon: Icon(CupertinoIcons.lock),
                        sufixIcon: IconButton(
                          onPressed: () {
                            _passwordNotifier.value = !_passwordNotifier.value;
                          },
                          icon: Icon(
                            (value)
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded,
                          ),
                          iconSize: 22,
                        ),
                        labelText: 'Mot de passe',
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'veillez entrer un mot de passe';
                          }
                          _formData['password'] = value;
                          return null;
                        },
                      );
                    }),
                // BlocBuilder<RegistorBloc, RegistorState>(
                //   builder: (context, state) {
                //     return CustomLoadingButtom(
                //       text: 'Se connecter',

                //       isLoading: state is RegistorPendingState,
                //       //color: Colors.white,
                //       textColor: Colors.white,
                //       onClick: () async {
                //         if (_formKey.currentState!.validate()) {
                //           // Process data.
                //           inspect(_formData);

                //           context.read<RegistorBloc>().add(LoginEvent(
                //                 data: _formData,
                //                 context: context,
                //               ));
                //         }
                //       },
                //     );
                //   },
                // ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          // MaterialPageRoute(
                          //   builder: (context) => ResetPassword(),
                          // ));
                        },
                        child: Text(
                          'Mot de passe oublié?',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        )),
                    TextButton(
                        onPressed: () {
                          // Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => RegistorPage(),
                          //     ),
                          //     (route) => false);
                        },
                        child: Text(
                          'S\'inscrire',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        )),
                  ],
                ),
                // CustomButtom(
                //   text: 'Explorer',
                //   textColor: Colors.grey[700],
                //   color: CupertinoColors.systemFill,
                //   onClick: () async {
                //     UserModel.fromJson(UserModel.internal().toJson());
                //     await LocalStorage().deleteUser();
                //     Navigator.pushAndRemoveUntil(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => Application(
                //               //explore: true,
                //               ),
                //         ),
                //         (route) => false);
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: SizedBox(
      //     height: 50,
      //     child: Center(
      //       child: Text(
      //         '©AfriqueSolus',
      //         style: TextStyle(color: Color.fromARGB(255, 182, 181, 181)),
      //       ),
      //     )),
    );
  }
}
