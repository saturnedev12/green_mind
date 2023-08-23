import 'package:google_maps_flutter/google_maps_flutter.dart';

enum InfoWindowType { position, destination }

class CityCabInfoWindow {
  final String? name;
  final LatLng? position;
  final InfoWindowType type;

  const CityCabInfoWindow({this.name, this.position,required this.type});
}
