import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TravelMapScreen extends StatefulWidget {
  @override
  _TravelMapScreenState createState() => _TravelMapScreenState();
}

class _TravelMapScreenState extends State<TravelMapScreen> {
  GoogleMapController? _mapController;
  bool _isWalkingMode = false;

  void toggleWalkingMode() {
    setState(() {
      _isWalkingMode = !_isWalkingMode;
      updateCamera();
    });
  }

  void updateCamera() {
    if (_isWalkingMode) {
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(37.7749, -122.4194),
            zoom: 18.0,
            tilt: 45.0,
          ),
        ),
      );
    } else {
      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(37.7749, -122.4194),
            zoom: 12.0,
            tilt: 0.0,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Map'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194),
          zoom: 12.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleWalkingMode,
        child:
            Icon(_isWalkingMode ? Icons.directions_walk : Icons.directions_car),
      ),
    );
  }
}
