import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as l2;
import '../data/models/firebase_field.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import '../utils/app_dialog.dart';

class FireStoreServices {
  static final carburant = FirebaseFirestore.instance.collection('fields');
  static List<double> convertLatLngToArray(LatLng latLng) {
    return [latLng.latitude, latLng.longitude];
  }

  static Map<String, dynamic> convertLatLngToMap(LatLng latLng) {
    return {"latitude": latLng.latitude, "longitude": latLng.longitude};
  }

  static List<Map<String, dynamic>> _createListCordinate(List<LatLng> points) {
    List<Map<String, dynamic>> _data = [];
    points.forEach((e) {
      _data.add(convertLatLngToMap(e));
    });
    return _data;
  }

  static List<LatLng> createListeFromCordinate(
      List<dynamic> points) {
    List<LatLng> _data = [];
    points.forEach((e) {
      print('added');
      _data.add(LatLng(e['latitude'], e['longitude']));
    });

    return _data;
  }
  static List<l2.LatLng> createListeFromCordinate2(
      List<dynamic> points) {
    List<l2.LatLng> _data = [];
    points.forEach((e) {
      print('added');
      _data.add(l2.LatLng(e['latitude'], e['longitude']));
    });

    return _data;
  }
  static List<mp.LatLng> createListeFromCordinate3(
      List<dynamic> points) {
    List<mp.LatLng> _data = [];
    points.forEach((e) {
      print('added');
      _data.add(mp.LatLng(e['latitude'], e['longitude']));
    });

    return _data;
  }

  // creer un terr
  static Future<bool> createField(
      {required String fieldname,
      required List<LatLng> polygone,
      required BuildContext context}) async {
    bool result = true;
    List<Map<String, dynamic>> _data = [];
    await Future.sync(() {
      _data = _createListCordinate(polygone);
    });

    await carburant.add({
      'user_id': FirebaseAuth.instance.currentUser?.uid,
      'fieldname': fieldname,
      'polygone': _data,
      'is_paid': false,
    }).then((value) {
      log("Field is added: $value", name: 'FIRE STORE');
      result = true;
      /*AppDialog.info(
        content: "Maintenance enregistré",
        context: context,
        icon: Icon(CupertinoIcons.check_mark_circled),
        */ /*  rollBackAction: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
                (route) => false);
      },*/ /*
      );*/
    }).catchError((error) {
      log("Failed to add : $error");
      result = false;
    });
    return result;
  }

  getPolygones() {}

  static Future<List<FireBaseField>> getArticlesByUserId() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('fields')
        .where('user_id',
            isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();
inspect(querySnapshot.docs);
    List<FireBaseField> fields = querySnapshot.docs
        .map((DocumentSnapshot document) =>
            FireBaseField.fromJson(document.data() as Map<String, dynamic>))
        .toList();
    inspect(fields);

    /*querySnapshot.docs.forEach((doc) {
      fields.add(FireBaseField.fromJson(doc.data() as Map<String,dynamic>));
    });*/

    return fields;
  }
}
