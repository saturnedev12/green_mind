import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../bloc/map_utils.dart';
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
    return FloatingActionButton(
      onPressed: () async {
        await Future.sync(() async {
          Position? pos = await _getCurrentLocation();
          if (pos != null) {
            MapUtils.mapUtilsFunctions.addPoint(pos, context: context);
          }
        });

        //context.read<MapBloc>().add(SendPositionEvent());
      },
      child: const Icon(CupertinoIcons.flag_fill),
    );
  }
}
