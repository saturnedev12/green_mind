// ignore_for_file: use_build_context_synchronously
library maplib;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenmind/feature/delimitation/bloc/map_utils_functions.dart';
import 'map_state.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenmind/feature/delimitation/widgets/scrollable_sheet_info.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'map_bloc.dart';
import 'map_state.dart';
import 'map_utils.dart';

part 'map_function.dart';
part 'map_distances_setter.dart';

// More parts

class MapUtils {
  //attribut of map system
  /// conter pour les ID ordonnéé de tout les markers
  static int markerCounter = -1;

  /// conter pour l'ID des marker bornes
  static int borneMarkerCounter = -1;

  /// les marker qui afficheront les distances
  static List<Marker> markerToShow = [];

  /// conteur des marker de distance
  static int distanceMarkerCounter = 0;

  /// les IDs des markers qui affichent les distances
  static List<int> markerToShowID = [];
  static Set<Marker> markers = {};
  static Set<Polygon> polygons = {};
  static Set<Polyline> polylines = {};

  /// liste des points pour faire un chemin
  static List<LatLng> path = [];
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

  //static List<LatLng> pathBuffer = [];
  static Uint8List? icon;
  static LatLng? starDrag;
  static GoogleMapController? mapController;
  static GoogleMapController? secondMapController;
  static CameraPosition? bigMapPosition;
  static double zoomMiniMap = 15;

  /// All fuctions of map
  static MapUtilsFunctions mapUtilsFunctions = MapUtilsFunctions();

  MapUtils._internal() {}

  factory MapUtils() {
    return _instance;
  }
}
