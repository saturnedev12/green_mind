import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class SimpleMap extends StatelessWidget {
  const SimpleMap({super.key, this.points, this.center});
  final List<LatLng>? points;
  final LatLng? center;
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
          center: center ?? LatLng(5.281413, -4.143337),
          zoom: 16.5,
          onTap: ((tapPosition, point) => log(point.toString()))),
      nonRotatedChildren: [
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () =>
                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        PolygonLayer(
          polygons: [
            Polygon(
              points: points ??
                  [
                    LatLng(5.2800899816145135, -4.1450368613004684),
                    LatLng(5.280310992566902, -4.141850396990776),
                    LatLng(5.2830045154847465, -4.142181985080242),
                    LatLng(5.2827965257211495, -4.143986776471138),
                    LatLng(5.281315222608827, -4.144642241299152),
                    LatLng(5.281318227284025, -4.145294688642025),
                    LatLng(5.2800899816145135, -4.1450368613004684),
                  ],
              color: Colors.blue.withOpacity(0.8),
              isFilled: true,
            ),
          ],
        ),
      ],
    );
  }
}
