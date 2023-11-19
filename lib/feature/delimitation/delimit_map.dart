import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenmind/feature/delimitation/bloc/map_state.dart';
import 'package:greenmind/feature/delimitation/handler.dart';
import 'package:greenmind/feature/delimitation/widgets/bottom_stake.dart';
import 'package:greenmind/feature/delimitation/widgets/map_body.dart';
import 'package:greenmind/feature/delimitation/widgets/text_field_map.dart';
import 'package:greenmind/maplib/maplib.dart';

import 'widgets/map_app_bar.dart';

class DelimiteMap extends StatefulWidget {
  @override
  _DelimiteMapState createState() => _DelimiteMapState();
}

class _DelimiteMapState extends State<DelimiteMap> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    if (MapUtils.icon == null) {
      MapDisplayFunction.getBytesFromAsset('assets/map/pin.png', 50)
          .then((value) => MapUtils.icon = value);
    }

    //_startListening();
  }

  void onSerachAddMaker(LatLng latLng) async {
    MapFunctions(context: context).clearPoint();
  }

  Future<void> _getCurrentLocation() async {
    await Handler.requestLocationPermission();
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).then(
        (value) {
          MapUtils.currentPosition = value;
          return value;
        },
      );
      //_path.add(LatLng(position.latitude, position.longitude));
    }
  }

  final TextEditingController _placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MapAppBar(),
      body: MapUtils.currentPosition != null
          ? Stack(
              children: [
                MapBody(),
                // MiniMap(),
                if (MapUtils.mapNotifier.value == MODEDELIMITE.map)
                  TextFieldMap(textEditingController: _placeController),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: BotttomStake(),
      // ValueListenableBuilder<MODEDELIMITE>(
      //   valueListenable: MapUtils.mapNotifier,
      //   builder: (context, value, child) => (value == MODEDELIMITE.browse)
      //       ? const BottomBrowse()
      //       : (value == MODEDELIMITE.stake)
      //           ? const BotttomStake()
      //           : SizedBox(),
      //),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
