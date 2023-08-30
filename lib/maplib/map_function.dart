part of maplib;

//import 'dart:async';
// import 'dart:developer';
// import 'dart:math' as math;
// import 'dart:ui' as ui;

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:greenmind/feature/delimitation/widgets/scrollable_sheet_info.dart';
// import 'package:maps_toolkit/maps_toolkit.dart' as mp;

// import 'map_bloc.dart';
// import 'map_state.dart';
// import 'map_utils.dart';

class MapFunctions {
  MapFunctions({required this.context});
  BuildContext context;

  /// ajouter des markers
  _addMarkers() async {
    await Future.sync(() {
      MapUtils.path.asMap().forEach((key, value) {
        MapUtils.markers.add(
          Marker(
            markerId: MarkerId(key.toString()),
            position: value,
            icon: BitmapDescriptor.fromBytes(MapUtils.icon!),
            infoWindow: InfoWindow(title: 'B${key + 1}'),
          ),
        );
      });
    });
  }

  _addPolygone() async {
    await Future.sync(() {
      MapUtils.polygons.add(
        Polygon(
          polygonId: PolygonId('Poly'),
          points: MapUtils.path,
          fillColor: Colors.green.withOpacity(0.4),
          strokeColor: Colors.red,
          strokeWidth: 2,
        ),
      );
    });
  }

  _addPolylines() async {
    await Future.sync(() {
      MapUtils.polylines.add(
        Polyline(
          polylineId: PolylineId('route'),
          points: MapUtils.path,
          color: Colors.red,
          width: 2,
        ),
      );
    });
  }

  /// ajouter des point dans le chemin
  _addPointInPath(Position position) async {
    MapUtils.markerCounter += 2;
    MapUtils.borneMarkerCounter += 1;
    await Future.sync(() {
      MapUtils.path.add(LatLng(position.latitude, position.longitude));
    });
  }

  /// supprimer dernier marker
  _removeLastMarker() async {
    await Future.sync(() {
      MapUtils.markers.removeWhere(
          (e) => e.markerId.value == (MapUtils.path.length - 1).toString());
    });
    await Future.sync(() {
      print("D${(MapUtils.path.length - 1)}");
      MapUtils.markers.removeWhere(
          (e) => e.markerId.value == "D${(MapUtils.path.length - 1)}");
      MapUtils.markers.removeWhere(
          (e) => e.markerId.value == "D${(MapUtils.path.length - 2)}");
      MapUtils.distanceMarkerCounter -= 1;
    });
  }

  /// supprimer dernier point
  _removeLastPoint() async {
    await Future.sync(() {
      MapUtils.path.removeLast();
    });
  }

  /// gestionnaire d'ajout de points
  addPointHandler({required Position position}) async {
    await _addPointInPath(position);
    await _addMarkers();
    await _addPolylines();
    await _addPolygone();
    await MapDistancesSetter.addDistance();
  }

  clearPoint() async {
    await Future.sync(() {
      MapUtils.markers.clear();
      MapUtils.path.clear();
      MapUtils.polygons.clear();
      MapUtils.polylines.clear();
    });
  }

  /// revenir en arrière
  rollBack() async {
    // suprimer les dernier élément des Point
    // et des marker lorsqu'il y a au moins un point
    if (MapUtils.path.isNotEmpty) {
      await _removeLastMarker();
      await _removeLastPoint();
    }

    context.read<MapBloc>().add(SendPositionEvent());
  }

  // TODO: Deplacer point avec les ID
  //creer une nouvelle lite de point avec le point en question en ID
  // parcourir avec les marker
}
