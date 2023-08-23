import 'dart:async';
import 'dart:convert' as convert;
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import '../../components/info_window/custom_info_window.dart';
import '../../components/info_window/custom_widow.dart';
import '../../images_assets.dart';
import '../models/address.dart';
import '../models/citycab_info_window.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:ui' as ui;


class Deley {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Deley({this.milliseconds});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(microseconds: milliseconds ?? 400), action);
  }
}

class LocationService {
  LocationService._();

  static LocationService? _instance;

  static LocationService? get instance {
    _instance ??= LocationService._();
    return _instance;
  }

  Duration duration = Duration(days: 1);
  final _deley = Deley(milliseconds: 2000);
  final String key = 'AIzaSyD0OFIF-WwrQRVpD3acbegQoIGapwtkAOk';
  final String types = 'address';
  Future<Map<String, dynamic>> getPlace(String input) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$input&key=$key";
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;
    print(results);

    return results;
  }

  

  ValueNotifier<Set<Marker>> markers = ValueNotifier<Set<Marker>>({});
  ValueNotifier<Set<Marker>> trajetMarkers = ValueNotifier<Set<Marker>>({});
  ValueNotifier<Address?>? currentPosition = ValueNotifier<Address?>(null);

  CustomInfoWindowController? controller;

  Future<Set<Marker>> addMarker(
      String markerId, Address? address, BitmapDescriptor icon, int size,
      {required DateTime time, required InfoWindowType type}) async {
    if (address != null) {
      final Uint8List markerIcon = await getBytesFromAsset(
          type == InfoWindowType.position
              ? ImagesAsset.circlePin
              : ImagesAsset.pin,
          size);
      final icon = BitmapDescriptor.fromBytes(markerIcon);
      print("on a ici marker");
      final marker = Marker(
          markerId: MarkerId(markerId),
          position: LatLng(address.latLng!.latitude, address.latLng!.longitude),
          icon: icon,
          onTap: () {
            controller!.addInfoWindow!(
              CustomWindow(
                info: CityCabInfoWindow(
                  position: LatLng(
                      address.latLng!.latitude, address.latLng!.longitude),
                  type: type,
                ),
              ),
              address.latLng!,
            );
          });
      if (type != InfoWindowType.destination  || type != InfoWindowType.destination ) {
        markers.value.clear();
      markers.value.add(marker);
      }
     
      controller!.addInfoWindow!(
        CustomWindow(
          info: CityCabInfoWindow(
            position:
                LatLng(address.latLng!.latitude, address.latLng!.longitude),
            type: type,
          ),
        ),
        address.latLng!,
      );

      Timer(const Duration(seconds: 1), () => controller!.hideInfoWindow);
    

      try {
        final markerPosition = markers.value
            .firstWhere((marker) => marker.markerId.value == markerId);
        markerPosition.copyWith(
            positionParam:
                LatLng(address.latLng!.latitude, address.latLng!.longitude));
        return markers.value;
      } catch (e) {
        markers.value.add(marker);
        return markers.value;
      }
    } else {
      return markers.value;
    }
  }
  Future<Set<Marker>> addTrajetMarker(
      String markerId, Address? address, BitmapDescriptor icon, int size,
      {required DateTime time, required InfoWindowType type}) async {
    if (address != null) {
      final Uint8List markerIcon = await getBytesFromAsset(
          type == InfoWindowType.position
              ? ImagesAsset.circlePin
              : ImagesAsset.pin,
          size);
      final icon = BitmapDescriptor.fromBytes(markerIcon);
      print("on a ici marker");
      final marker = Marker(
          markerId: MarkerId(markerId),
          position: LatLng(address.latLng!.latitude, address.latLng!.longitude),
          icon: icon,
          onTap: () {
            controller!.addInfoWindow!(
              CustomWindow(
                info: CityCabInfoWindow(
                  position: LatLng(
                      address.latLng!.latitude, address.latLng!.longitude),
                  type: type,
                ),
              ),
              address.latLng!,
            );
          });
      if (type != InfoWindowType.destination  || type != InfoWindowType.destination ) {
        trajetMarkers.value.clear();
      trajetMarkers.value.add(marker);
      }
     
      controller!.addInfoWindow!(
        CustomWindow(
          info: CityCabInfoWindow(
            position:
                LatLng(address.latLng!.latitude, address.latLng!.longitude),
            type: type,
          ),
        ),
        address.latLng!,
      );

      Timer(const Duration(seconds: 1), () => controller!.hideInfoWindow);
    

      try {
        final markerPosition = trajetMarkers.value
            .firstWhere((marker) => marker.markerId.value == markerId);
        markerPosition.copyWith(
            positionParam:
                LatLng(address.latLng!.latitude, address.latLng!.longitude));
        return trajetMarkers.value;
      } catch (e) {
        trajetMarkers.value.add(marker);
        return trajetMarkers.value;
      }
    } else {
      return trajetMarkers.value;
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<double> getPositionBetweenKilometers(
      LatLng startLatLng, LatLng endLatLng) async {
    final meters = Geolocator.distanceBetween(startLatLng.latitude,
        startLatLng.longitude, endLatLng.latitude, endLatLng.longitude);
    return meters / 500;
  }

  Future<Address?> getCurrentPosition(Address address) async {
    final check = await requestAndCheckPermission();
    final icon = await getMapIcon(ImagesAsset.pin);
    return currentPosition?.value;
  }

  Future<BitmapDescriptor> getMapIcon(String iconPath) async {
    final Uint8List endMarker = await getBytesFromAsset(iconPath, 20);
    final icon = BitmapDescriptor.fromBytes(endMarker);
    return icon;
  }

  Future<bool> requestAndCheckPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final request = await Geolocator.requestPermission();
      if (request == LocationPermission.always) {
        return true;
      } else {
        return false;
      }
    } else if (permission == LocationPermission.always) {
      return true;
    } else {
      return false;
    }
  }

  Future<Address> getAddressFromCoodinate(LatLng position,
      {List<PointLatLng>? polylines}) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final placemark = placemarks.first;
    final address = Address(
      street: placemark.street,
      city: placemark.locality,
      state: placemark.administrativeArea,
      country: placemark.country,
      latLng: position,
      polylines: polylines ?? [],
    );
    return address;
  }
}
