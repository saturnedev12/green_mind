import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../bloc/map_utils.dart';

class BottomBrowse extends StatefulWidget {
  const BottomBrowse({super.key});

  @override
  State<BottomBrowse> createState() => _BottomBrowseState();
}

class _BottomBrowseState extends State<BottomBrowse> {
  bool isPlay = false;
  void _startListening() {
    MapUtils.positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 1,
      //timeLimit: const Duration(milliseconds: 500),
    )).listen((Position position) async {
      print(position);
      await Future.sync(() {
        MapUtils.mapUtilsFunctions.addPoint(position, context: context);
      });
      //context.read<MapBloc>().add(SendPositionEvent());
    }, onError: (error) {
      // Gérez les erreurs éventuelles lors de l'écoute des positions
    });
  }

  void _stopListening() {
    MapUtils.positionStreamSubscription?.cancel();
    MapUtils.positionStreamSubscription = null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // MapUtils.getBytesFromAsset('assets/map/pin.png', 50)
    //     .then((value) => MapUtils.icon = value);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          if (isPlay) {
            _stopListening();
          } else {
            _startListening();
          }
          isPlay = !isPlay;
        });

        // isPlay ? _stopListening() : _startListening;
        // setState(() {
        //
        // });
        // _startListening();
      },
      child: isPlay
          ? Icon(CupertinoIcons.pause_fill)
          : Icon(CupertinoIcons.play_arrow_solid),
    );
  }
}
