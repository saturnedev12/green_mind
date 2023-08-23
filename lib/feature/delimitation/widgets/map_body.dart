import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenmind/feature/delimitation/bloc/map_utils_functions.dart';

import '../bloc/map_bloc.dart';
import '../bloc/map_state.dart';
import '../bloc/map_utils.dart';

class MapBody extends StatelessWidget {
  MapBody({super.key});
  String scale = '';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            MapUtils.mapController = controller;
          },
          onCameraMove: (CameraPosition position) async {
            MapUtils.mapUtilsFunctions.updateSecondMapPosition(position.target);
            MapUtils.bigMapPosition = position;
            scale = await MapUtils.mapUtilsFunctions.calculateScale(
                mapController: MapUtils.mapController!, context: context);
            // if (MapUtils.mapController != null) {
            //   MapUtils.mapController!
            //       .moveCamera(CameraUpdate.newCameraPosition(position));
            // }
          },
          onTap: (MapUtils.mapNotifier.value == MODEDELIMITE.map)
              ? (point) {
                  //
                  MapUtils.mapUtilsFunctions.addPoint(
                      Position(
                          longitude: point.longitude,
                          latitude: point.latitude,
                          timestamp: DateTime.now(),
                          accuracy: 0,
                          altitude: 0,
                          heading: 0,
                          speed: 0,
                          speedAccuracy: 0),
                      context: context);
                  context.read<MapBloc>().add(SendPositionEvent());
                }
              : null,

          polygons: MapUtils.polygons,

          mapType: MapType.satellite,
          polylines: MapUtils.polylines,
          markers: MapUtils.markers,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              MapUtils.currentPosition!.latitude,
              MapUtils.currentPosition!.longitude,
            ),
            zoom: 30,
            tilt: 40.0,
          ),
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,

          // onMapCreated: (controller) {
          //   setState(() {
          //     _mapController = controller;
          //   });
          // },
        );
      },
    );
  }
}
