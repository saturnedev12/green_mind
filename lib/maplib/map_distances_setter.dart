part of maplib;

class MapDistancesSetter {
  static addDistance() async {
    await Future.sync(() async {
      /***
     * ajouter le un point q lq position initial pour boucler la map
     * mettre a jours la distance entre le dernier point et le premier
    */

      if ((MapUtils.path.length > 2)) {
        MapUtils.path.add(MapUtils.path.first);
        // MapUtils.markers.remove(MapUtils.markerToShow.last);
        // MapUtils.markerToShow.removeLast();
      }
      if (MapUtils.path.length >= 2) {
        MapUtils.distanceMarkerCounter += 1;
        for (int i = 0; i < MapUtils.path.length - 1; i++) {
          LatLng startPoint = MapUtils.path[i];
          LatLng endPoint = MapUtils.path[i + 1];
          // distance entre les deux points
          num distance = mp.SphericalUtil.computeDistanceBetween(
              mp.LatLng(startPoint.latitude, startPoint.longitude),
              mp.LatLng(endPoint.latitude, endPoint.longitude));
          // cordonnee de la position au milieu
          mp.LatLng middlePosition = mp.SphericalUtil.interpolate(
            mp.LatLng(startPoint.latitude, startPoint.longitude),
            mp.LatLng(endPoint.latitude, endPoint.longitude),
            0.5,
          );
          // creer l'image a partir du text de la distance
          ui.Image textImage =
              await _createTextImage(convertDistance(distance));

          BitmapDescriptor customMarkerIcon = BitmapDescriptor.fromBytes(
            await _imageToByteData(textImage),
          );

          final Marker dMarker = Marker(
              markerId: MarkerId("D$i"),
              position:
                  LatLng(middlePosition.latitude, middlePosition.longitude),
              // infoWindow: InfoWindow(title: "DISTANCE"),
              icon: customMarkerIcon);
          //MapUtils.markerToShow.add(dMarker);
          MapUtils.markers.add(dMarker);
        }
      }

      // je supprime le dernier point ajouté pour former la boucle
      if (MapUtils.path.length > 2) {
        MapUtils.path.removeLast();
      }
    });
  }

  /// creer une image a partir d'un texte
  static Future<ui.Image> _createTextImage(String text) async {
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

  /// mettre la distance dans le forma mettre ou kilomètre
  static String convertDistance(num distance) {
    if (distance < 1000) {
      return '${distance.toStringAsFixed(3)} m';
    } else {
      final convertedDistance = (distance / 1000).toStringAsFixed(3);
      return '$convertedDistance km';
    }
  }

  /// convertir image en bite pour la map
  static Future<Uint8List> _imageToByteData(ui.Image image) async {
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}
