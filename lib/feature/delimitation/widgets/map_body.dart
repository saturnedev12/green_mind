import 'dart:developer';

import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenmind/feature/delimitation/bloc/map_utils_functions.dart';
import 'package:greenmind/maplib/maplib.dart';

import '../bloc/map_bloc.dart';
import '../bloc/map_state.dart';

class MapBody extends StatelessWidget {
  MapBody({super.key});
  String scale = '';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        log("REBUILD MAP");
        return Stack(
          children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                MapUtils.mapController = controller;
              },
              onCameraMove: (CameraPosition position) async {
                MapDisplayFunction(context: context)
                    .updateSecondMapPosition(position.target);
                MapUtils.bigMapPosition = position;
                // scale = await MapUtils.mapUtilsFunctions.calculateScale(
                //     mapController: MapUtils.mapController!, context: context);
                // if (MapUtils.mapController != null) {
                //   MapUtils.mapController!
                //       .moveCamera(CameraUpdate.newCameraPosition(position));
                // }
              },
              // onTap: (MapUtils.mapNotifier.value == MODEDELIMITE.map)
              //     ? (point) {
              //         //
              //         MapFunctions(context: context).addPointHandler(
              //           position: Position(
              //               longitude: point.longitude,
              //               latitude: point.latitude,
              //               timestamp: DateTime.now(),
              //               accuracy: 0,
              //               altitude: 0,
              //               heading: 0,
              //               speed: 0,
              //               speedAccuracy: 0),
              //         );
              //         context.read<MapBloc>().add(SendPositionEvent());
              //       }
              //     : null,

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
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Center(
                child: AnimateIcon(
                  key: UniqueKey(),
                  onTap: () {},
                  iconType: IconType.continueAnimation,
                  height: 90,
                  width: 90,
                  color: Colors.green,
                  // color: Color.fromRGBO(
                  //     Random.secure().nextInt(255),
                  //     Random.secure().nextInt(255),
                  //     Random.secure().nextInt(255),
                  //     1),
                  animateIcon: AnimateIcons.mapPointer,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
