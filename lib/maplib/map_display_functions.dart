part of maplib;

class MapDisplayFunction {
  BuildContext context;
  MapDisplayFunction({required this.context});

  /// afficher les information primaire dans une popup
  displayPopupInfo({required BuildContext context}) async {
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
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
            // CupertinoDialogAction(
            //   /// This parameter indicates the action would perform
            //   /// a destructive action such as deletion, and turns
            //   /// the action's text color to red.
            //   isDestructiveAction: true,
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   child: const Text('Yes'),
            // ),
          ],
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

      await Future.sync(() {
        List<Marker> _markers = [];
        for (Marker marker in MapUtils.markers) {
          bool exists = _markers.any((existingMarker) =>
              ((existingMarker.markerId.value == marker.markerId.value)));

          if (!exists) {
            if (marker.infoWindow.title != null) {
              _markers.add(marker);
            }
          }
        }
        log(_markers.toString());
        showModalBottomSheet(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: CupertinoColors.white,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return ScrollableSheetInfo(
                markers: _markers, perimetre: perimetre, surface: surface);
          },
        );

        inspect(_markers);
      });
    }
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

  String convertDistance(num distance) {
    if (distance < 1000) {
      return '${distance.toStringAsFixed(3)} m';
    } else {
      final convertedDistance = (distance / 1000).toStringAsFixed(3);
      return '$convertedDistance km';
    }
  }

  /// convert and returnn surface with unit
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

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
