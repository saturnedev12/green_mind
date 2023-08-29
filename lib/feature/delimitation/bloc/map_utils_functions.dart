// ignore_for_file: use_build_context_synchronously

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

class MapUtilsFunctions {
  // convert and returnn surface with unit
  String convertSurface(num value) {
    if (value < 1000) {
      return '${value.toStringAsFixed(3)} m²';
    } else if (value >= 1000 && value < 10000) {
      final convertedDistance = (value / 1000).toStringAsFixed(3);
      return '$convertedDistance km²';
    } else {
      final convertedDistance = (value / 10000).toStringAsFixed(3);
      return '$convertedDistance ha';
    }
  }

  Future<Uint8List> _imageToByteData(ui.Image image) async {
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<ui.Image> _createTextImage(String text) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final textStyle = ui.TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    );
    final paragraphStyle = ui.ParagraphStyle(
      textAlign: TextAlign.center,
    );

    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(text);

    final paragraph = paragraphBuilder.build();
    paragraph.layout(const ui.ParagraphConstraints(width: 120.0));
    double width = 120.0;
    double height = 40;
    final path = Path()
      ..moveTo(12, 0)
      ..lineTo(width - 12, 0)
      ..quadraticBezierTo(width, 0, width, 12)
      ..lineTo(width, height - 12)
      ..quadraticBezierTo(width, height, width - 12, height)
      ..lineTo(width * 0.30, height)
      ..lineTo(width * 0.5, height + 20)
      ..lineTo(width * 0.70, height)
      ..lineTo(12, height)
      ..quadraticBezierTo(0, height, 0, height - 12)
      ..lineTo(0, 12)
      ..quadraticBezierTo(0, 0, 12, 0)
      ..close();
    canvas.drawPath(path, Paint()..color = Colors.white);

    canvas.drawParagraph(paragraph, Offset(0.0, 5.0));

    return pictureRecorder.endRecording().toImage(120, 60);
  }

  addDistance({required BuildContext context}) async {
    /***
     * ajouter le un point q lq position initial pour boucler la map
     * mettre a jours la distance entre le dernier point et le premier
    */
    if ((MapUtils.path.length >= 2)) {
      MapUtils.path.add(MapUtils.path.first);
      MapUtils.markers.remove(MapUtils.markerToShow.last);
      MapUtils.markerToShow.removeLast();
    }
    await Future.sync(() async {
      for (int i = 0; i < MapUtils.path.length - 1; i++) {
        LatLng startPoint = MapUtils.path[i];
        LatLng endPoint = MapUtils.path[i + 1];

        num distance = mp.SphericalUtil.computeDistanceBetween(
            mp.LatLng(startPoint.latitude, startPoint.longitude),
            mp.LatLng(endPoint.latitude, endPoint.longitude));

        mp.LatLng middlePosition = mp.SphericalUtil.interpolate(
          mp.LatLng(startPoint.latitude, startPoint.longitude),
          mp.LatLng(endPoint.latitude, endPoint.longitude),
          0.5,
        );

        ui.Image textImage = await _createTextImage(convertDistance(distance));

        BitmapDescriptor customMarkerIcon = BitmapDescriptor.fromBytes(
          await _imageToByteData(textImage),
        );

        final Marker dMarker = Marker(
            markerId: MarkerId(MapUtils.markerToShowID[i].toString()),
            position: LatLng(middlePosition.latitude, middlePosition.longitude),
            infoWindow: InfoWindow(title: "DISTANCE"),
            icon: customMarkerIcon);
        MapUtils.markerToShow.add(dMarker);
        MapUtils.markers.add(dMarker);
      }
    });
    context.read<MapBloc>().add(SendPositionEvent());
    if (MapUtils.path.length > 2) {
      MapUtils.path.removeLast();
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  _repaint({required Position position, required BuildContext context}) async {
    await Future.sync(() {
      MapUtils.polylines.add(
        Polyline(
          polylineId: PolylineId('route'),
          points: MapUtils.path,
          color: Colors.red,
          width: 2,
        ),
      );
      MapUtils.markers.add(
        Marker(
          markerId: MarkerId(MapUtils.markerCounter.toString()),
          position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.fromBytes(MapUtils.icon!),
          infoWindow: InfoWindow(title: 'B${MapUtils.borneMarkerCounter}'),
        ),
      );
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
    context.read<MapBloc>().add(SendPositionEvent());
  }

  addPoint(Position position, {required BuildContext context}) async {
    /**
     * le compter pass de 2 en 2
     */
    MapUtils.markerCounter += 2;
    MapUtils.borneMarkerCounter += 1;
    if (MapUtils.markerCounter > 2) {
      MapUtils.markerToShowID.add(MapUtils.markerCounter - 1);
    }
    await Future.sync(() async {
      MapUtils.path.add(LatLng(position.latitude, position.longitude));

      await _repaint(position: position, context: context);
    });
    await addDistance(context: context);
    // if (MapUtils.mapNotifier.value != MODEDELIMITE.browse) {

    // }
    context.read<MapBloc>().add(SendPositionEvent());
  }

  /// clean points
  rollBackPoint({required BuildContext context}) async {
    rollbackMarkers();
    await Future.sync(() {
      MapUtils.polylines.remove(MapUtils.polylines.last);
      MapUtils.markers.removeWhere(
          (e) => e.markerId.value == MapUtils.markerCounter.toString());
      MapUtils.markers.removeWhere(
          (e) => e.markerId.value == (MapUtils.markerCounter - 1).toString());
      MapUtils.path.removeLast();
      addDistance(context: context);
      // if (MapUtils.mapNotifier.value != MODEDELIMITE.browse) {

      // }
    });
    MapUtils.markerCounter -= 2;
    context.read<MapBloc>().add(SendPositionEvent());
  }

  /// clean Marker
  rollbackMarkers() async {
    await Future.sync(() {
      List<Marker> setList = MapUtils.markers.toList();
      setList.removeLast();

      // if (setList.length >= 3) {
      //   setList.removeRange(setList.length - 3, setList.length);
      // } else {
      //   setList.removeLast();
      // }
      inspect(setList);
      MapUtils.markerToShow.removeLast();
      MapUtils.markers.clear();
      MapUtils.markers.addAll(Set<Marker>.from(setList));
      MapUtils.markerCounter = 0;
    });
  }

  // undoPoint({required BuildContext context}) async {
  //   log(MapUtils.path.toString());

  //   if (MapUtils.pathBuffer.length > MapUtils.path.length) {
  //     await Future.sync(() {
  //       MapUtils.path.add(MapUtils.pathBuffer.first);
  //     });
  //     await Future.sync(() {
  //       MapUtils.pathBuffer.removeLast();
  //     });
  //   }
  //   context.read<MapBloc>().add(SendPositionEvent());
  // }

  clearPoints() async {
    await Future.sync(() {
      try {
        MapUtils.path.clear();
        MapUtils.markers.clear();
        MapUtils.polygons.clear();
        MapUtils.markerToShow.clear();
        MapUtils.polylines.clear();
        MapUtils.markerToShow.clear();
      } catch (e) {}
    });
  }

  void updateSecondMapPosition(LatLng currentPosition) async {
    if (MapUtils.secondMapController != null) {
      double zoom = await MapUtils.mapController!.getZoomLevel();
      MapUtils.secondMapController!
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: currentPosition,
        zoom: zoom - 3,
      )));
    }
  }

  displayPopupInfo({required BuildContext context}) {
    if (MapUtils.markerCounter < 3) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Icon(
            CupertinoIcons.exclamationmark_triangle,
            color: CupertinoColors.systemRed,
          ),
          content: const Text(
              'Vous devez placer au moins trois bornes pour former le polygone'),
          // actions: <CupertinoDialogAction>[
          //   CupertinoDialogAction(
          //     /// This parameter indicates this action is the default,
          //     /// and turns the action's text to bold text.
          //     isDefaultAction: true,
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     child: const Text('No'),
          //   ),
          //   CupertinoDialogAction(
          //     /// This parameter indicates the action would perform
          //     /// a destructive action such as deletion, and turns
          //     /// the action's text color to red.
          //     isDestructiveAction: true,
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     child: const Text('Yes'),
          //   ),
          // ],
        ),
      );
    } else {
      MapUtils.path.add(MapUtils.path.first);

      List<mp.LatLng> newPath = MapUtils.path
          .map(
            (e) => mp.LatLng(e.latitude, e.longitude),
          )
          .toList();
      MapUtils.path.removeLast();
      print(newPath);

      final surface = mp.SphericalUtil.computeArea(newPath);
      final perimetre = mp.SphericalUtil.computeLength(newPath);

      List<Marker> _markersAll = List.from(MapUtils.markers);
      List<Marker> _markers = _markersAll
          .where(
            (e) => e.infoWindow.title != null,
          )
          .toList();

      showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: CupertinoColors.white,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ScrollableSheetInfo(
              markers: _markers, perimetre: perimetre, surface: surface);
        },
      );
    }
  }

  String convertDistance(num distance) {
    if (distance < 1000) {
      return '${distance.toStringAsFixed(3)} m';
    } else {
      final convertedDistance = (distance / 1000).toStringAsFixed(3);
      return '$convertedDistance km';
    }
  }

  Future<String> calculateScale(
      {required GoogleMapController mapController,
      required BuildContext context}) async {
    double currentZoom = await mapController.getZoomLevel();
    //if (mapController == null || currentZoom == null) return 0.0;
    double lat = MapUtils.bigMapPosition!.target.latitude;
    double metersPerPixel = ((156543.03392 * math.cos(lat * math.pi / 180)) /
            math.pow(2, currentZoom)) *
        100;
    //return metersPerPixel;
    print('1/${metersPerPixel.toStringAsFixed(1)}');
    return '1/$metersPerPixel'; // Retourne l'échelle sous la forme "1/n"
  }
}
