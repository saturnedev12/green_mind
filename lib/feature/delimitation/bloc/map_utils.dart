// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenmind/feature/delimitation/bloc/map_utils_functions.dart';

import 'map_state.dart';

class MapUtils {
  //attribut of map system
  static int markerCounter = 0;
  static ValueNotifier<MODEDELIMITE> mapNotifier =
      ValueNotifier<MODEDELIMITE>(MODEDELIMITE.map);
  static final MapUtils _instance = MapUtils._internal();
  static Position? currentPosition = Position(
      latitude: 5.5058936,
      longitude: -4.0632231,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0);

  static StreamSubscription<Position>? positionStreamSubscription;
  static Set<Marker> markers = {};
  static Set<Polygon> polygons = {};
  static Set<Polyline> polylines = {};
  static List<LatLng> path = [];
  static List<LatLng> pathBuffer = [];
  static Uint8List? icon;
  static LatLng? starDrag;
  static GoogleMapController? mapController;
  static GoogleMapController? secondMapController;
  static List<Marker> markerToShow = [];
  static CameraPosition? bigMapPosition;
  static double zoomMiniMap = 15;

  //all fuctions of map
  static MapUtilsFunctions mapUtilsFunctions = MapUtilsFunctions();

  MapUtils._internal() {}

  factory MapUtils() {
    return _instance;
  }
}
