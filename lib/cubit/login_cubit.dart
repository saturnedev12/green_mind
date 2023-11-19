import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenmind/cubit/app_states/app_state.dart';

class LoginCubit extends Cubit<AppState> {
  LoginCubit() : super(InitialState());

  // _login(
  //     {required FormController formController,
  //     required BuildContext context}) async {
  //   TempUserModel _responseUser =
  //       await Repository<TempUserModel>(TempUserModel()).fetchData(
  //           requestInfo:
  //               AuthentificationAdapter(formController: formController).login(),
  //           context: context) as TempUserModel;

  //   UserModel.fromTempUser(_responseUser);
  //   await LocalStorage().storeUser();
  // }

  // _action({required BuildContext context}) {
  //   if (UserModel.singleton.id!.isNotEmpty) {
  //     GoRouter.of(context).replace(
  //       '/app',
  //     );
  //   }
  // }

  // _register(
  //     {required FormController formController,
  //     required BuildContext context}) async {
  //   inspect(formController.toJsonForOrder());

  //   TempUserModel _responseUser =
  //       await Repository<TempUserModel>(TempUserModel()).fetchData(
  //           requestInfo: AuthentificationAdapter(formController: formController)
  //               .register(),
  //           context: context) as TempUserModel;

  //   UserModel.fromTempUser(_responseUser);
  //   await LocalStorage().storeUser();
  // }

  // _updateUpser(
  //     {required BuildContext context, Map<String, dynamic>? data}) async {
  //   Response? response = await ApiProvider(context: context)
  //       .request(
  //     RequestInfo(
  //         method: METHOD.PATCH,
  //         path: RequestPath.updateUser(id: UserModel.singleton.id!),
  //         data: data ?? {}),
  //   )
  //       .then(
  //     (value) async {
  //       if (value!.statusCode == 200) {
  //         inspect(value.data['data']);
  //         UserModel.fromJson(value.data['data']);
  //         await LocalStorage().storeUser();
  //       } else {
  //         AppDialog.info(
  //             context: context,
  //             content: "Une erreur s'est produite",
  //             icon: Icon(Icons.info_outline_rounded));
  //       }
  //     },
  //   ).onError(
  //     (error, stackTrace) {
  //       inspect(stackTrace);
  //       AppDialog.info(
  //           context: context,
  //           content: error.toString(),
  //           icon: Icon(Icons.info_outline_rounded));
  //     },
  //   );
  // }

  // onSendData(
  //     {required FormController formController,
  //     required BuildContext context}) async {
  //   emit(PendingState());
  //   await _login(formController: formController, context: context);
  //   emit(FinishState<UserModel>(data: UserModel.singleton));
  //   _action(context: context);
  // }

  // registerSendData(
  //     {required FormController formController,
  //     required BuildContext context}) async {
  //   emit(PendingState());
  //   await _register(formController: formController, context: context);
  //   emit(FinishState<UserModel>(data: UserModel.singleton));
  //   _action(context: context);
  // }

  // updateData(
  //     {required FormController formController,
  //     required BuildContext context,
  //     Map<String, dynamic>? data}) async {
  //   emit(PendingState());
  //   await _updateUpser(context: context, data: {
  //     "first_name": formController.firstName!.text,
  //     "last_name": formController.lastName!.text,
  //     "email": formController.email!.text,
  //     "phone_number": formController.phoneNumber!.text,
  //     "city": formController.city,
  //   });
  //   emit(FinishState<UserModel>(data: UserModel.singleton));
  //   context.pop();
  // }

  // updateAvatar(
  //     {required String avatar,
  //     required BuildContext context,
  //     Map<String, dynamic>? data}) async {
  //   emit(PendingState<AccountState>());
  //   await _updateUpser(context: context, data: {
  //     "avatar": avatar,
  //   });
  //   await LocalStorage().storeUser();
  //   Constantes.buildNotifier.value = !Constantes.buildNotifier.value;
  //   emit(FinishState<AccountState>(data: AccountState()));
  // }
}

class AccountState extends AppState {}
