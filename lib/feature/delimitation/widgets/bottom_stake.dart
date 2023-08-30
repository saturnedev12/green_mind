import 'package:animated_button/animated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:greenmind/feature/delimitation/bloc/map_bloc.dart';
import 'package:greenmind/maplib/maplib.dart';

import '../handler.dart';

class BotttomStake extends StatefulWidget {
  const BotttomStake({super.key});

  @override
  State<BotttomStake> createState() => _BotttomStakeState();
}

class _BotttomStakeState extends State<BotttomStake> {
  Future<Position?> _getCurrentLocation() async {
    Handler.requestLocationPermission();
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true,
        //timeLimit: const Duration(microseconds: 500),
      );
      //_path.add(LatLng(position.latitude, position.longitude));
      return position;
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // MapUtils.getBytesFromAsset('assets/map/finish.png', 50)
    //     .then((value) => MapUtils.icon = value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      color: Colors.green,
      onPressed: () async {
        await SystemSound.play(SystemSoundType.click);
        await Future.sync(() async {
          //Position? pos = await _getCurrentLocation();
          // if (pos != null) {
          //   MapUtils.mapUtilsFunctions.addPoint(pos, context: context);
          // }
          await MapFunctions(context: context).addPointHandler(
              position: Position(
                  longitude: MapUtils.bigMapPosition!.target.longitude,
                  latitude: MapUtils.bigMapPosition!.target.latitude,
                  timestamp: DateTime.now(),
                  accuracy: 0,
                  altitude: 0,
                  heading: 0,
                  speed: 0,
                  speedAccuracy: 0));

          context.read<MapBloc>().add(SendPositionEvent());
        });
        // Ici, vous pouvez placer la logique à exécuter au clic
        //print("Button Clicked!");
      },
      height: 50,
      width: 170,
      shape: BoxShape.rectangle,
      //color: Color(0xFF2196F3), // Couleur du bouton
      child: const Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Placer une borne',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.ads_click_rounded,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
    // return FloatingActionButton(
    //   onPressed: () async {
    //     await Future.sync(() async {
    //       //Position? pos = await _getCurrentLocation();
    //       // if (pos != null) {
    //       //   MapUtils.mapUtilsFunctions.addPoint(pos, context: context);
    //       // }
    //       MapUtils.mapUtilsFunctions.addPoint(
    //           Position(
    //               longitude: MapUtils.bigMapPosition!.target.longitude,
    //               latitude: MapUtils.bigMapPosition!.target.latitude,
    //               timestamp: DateTime.now(),
    //               accuracy: 0,
    //               altitude: 0,
    //               heading: 0,
    //               speed: 0,
    //               speedAccuracy: 0),
    //           context: context);
    //     });

    //     //context.read<MapBloc>().add(SendPositionEvent());
    //   },
    //   child: const Icon(CupertinoIcons.flag_fill),
    // );
  }
}
