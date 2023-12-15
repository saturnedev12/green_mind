import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenmind/cubit/app_states/app_state.dart';
import 'package:greenmind/services/firestore_services.dart';

class FieldCubit extends Cubit<AppState> {
  FieldCubit() : super(InitialState());
  createField(
      {required String fieldname,
      required List<LatLng> polygone,
      required BuildContext context}) async {
    emit(PendingState());
    bool created = await FireStoreServices.createField(
        fieldname: fieldname, polygone: polygone, context: context);

    emit(FinishState<bool>(data: created));
    inspect(created);
    if(created){
      Navigator.pop(context);
    }
  }
}
