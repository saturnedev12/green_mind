import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/map_bloc.dart';
import '../bloc/map_utils.dart';

class MiniMap extends StatelessWidget {
  const MiniMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      //top: 85,
      bottom: 5,
      left: 6,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(blurRadius: 10, spreadRadius: 2),
          ],
        ),
        width: 150,
        height: 150,
        child: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
          return GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              MapUtils.secondMapController = controller;
            },
            minMaxZoomPreference: const MinMaxZoomPreference(10, 17),
            mapToolbarEnabled: false,
            compassEnabled: false,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
            mapType: MapType.satellite,
            polygons: MapUtils.polygons,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                MapUtils.currentPosition!.latitude,
                MapUtils.currentPosition!.longitude,
              ),
              zoom: 15.0,
              tilt: 0.0,
            ),
          );
        }),
      ),
    );
  }
}
