import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenmind/feature/map/simple_map.dart';
import 'package:greenmind/local_packages/utm/src/utm_base.dart';
import 'package:greenmind/maplib/maplib.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:latlong2/latlong.dart' as opens;
import 'package:test/test.dart';

class PolygonalPage extends StatefulWidget {
  const PolygonalPage({
    super.key,
    this.paths,
  });
  final List<LatLng>? paths;

  @override
  State<PolygonalPage> createState() => _PolygonalPageState();
}

class _PolygonalPageState extends State<PolygonalPage> {
  late GoogleMapController mapController;
  late GoogleMapController secondMapController;
  GlobalKey containerKey = GlobalKey();
  double mapZoom = 19;
  List<opens.LatLng>? openPoints;
  //final LatLng _center = const LatLng(5.281532, -4.143163);
  static Set<Marker> _markers = {};
  Set<Marker> _markerMap = {};

  Future<BitmapDescriptor> _genereateCustomMarkertext(
      {required String text}) async {
    ui.Image textImage = await MapDistancesSetter.createTextImage(text,
        color: Colors.green, textColor: Colors.white);
    BitmapDescriptor customMarkerIcon = BitmapDescriptor.fromBytes(
        await MapDistancesSetter.imageToByteData(textImage));

    return customMarkerIcon;
  }

  List<LatLng> paths = [
    LatLng(5.2800899816145135, -4.1450368613004684),
    LatLng(5.280310992566902, -4.141850396990776),
    LatLng(5.2830045154847465, -4.142181985080242),
    LatLng(5.2827965257211495, -4.143986776471138),
    LatLng(5.281315222608827, -4.144642241299152),
    LatLng(5.281318227284025, -4.145294688642025),
    LatLng(5.2800899816145135, -4.1450368613004684),
  ];
  List<String> distances = [];

  /// ajouter des markers
  Future<void> _addMarkers() async {
    await Future.sync(() async {
      paths.asMap().forEach((key, value) async {
        BitmapDescriptor customMarker = await _genereateCustomMarkertext(
            text: (key != (paths.length - 1)) ? 'B${key + 1}' : 'B1');
        _markers.add(
          Marker(
            markerId: MarkerId(key.toString()),
            position: value,
            icon: customMarker,
            infoWindow: InfoWindow(
                title: (key != (paths.length - 1)) ? 'B${key + 1}' : 'B1'),
          ),
        );
        if (key != (paths.length - 1)) {
          BitmapDescriptor customMarker = await _genereateCustomMarkertext(
              text: (key != (paths.length - 1)) ? 'B${key + 1}' : 'B1');
          _markerMap.add(
            Marker(
              markerId: MarkerId(key.toString()),
              position: value,
              icon: customMarker,
              infoWindow: InfoWindow(title: 'B${key + 1}'),
            ),
          );
        }
      });
    });
  }

  _addDistance() async {
    await Future.sync(() async {
      /***
     * ajouter le un point q lq position initial pour boucler la map
     * mettre a jours la distance entre le dernier point et le premier
    */

      // if ((paths.length > 2)) {
      //   paths.add(paths.first);
      //   // MapUtils.markers.remove(MapUtils.markerToShow.last);
      //   // MapUtils.markerToShow.removeLast();
      // }
      if (paths.length >= 2) {
        MapUtils.distanceMarkerCounter += 1;
        for (int i = 0; i < paths.length - 1; i++) {
          LatLng startPoint = paths[i];
          LatLng endPoint = paths[i + 1];
          // distance entre les deux points
          num distance = mp.SphericalUtil.computeDistanceBetween(
              mp.LatLng(startPoint.latitude, startPoint.longitude),
              mp.LatLng(endPoint.latitude, endPoint.longitude));
          // cordonnee de la position au milieu
          mp.LatLng middlePosition = mp.SphericalUtil.interpolate(
            mp.LatLng(startPoint.latitude, startPoint.longitude),
            mp.LatLng(endPoint.latitude, endPoint.longitude),
            0.5,
          );
          // creer l'image a partir du text de la distance
          ui.Image textImage = await MapDistancesSetter.createTextImage(
              MapDistancesSetter.convertDistance(distance));

          distances.add(MapDistancesSetter.convertDistance(distance));

          BitmapDescriptor customMarkerIcon = BitmapDescriptor.fromBytes(
            await MapDistancesSetter.imageToByteData(textImage),
          );

          final Marker dMarker = Marker(
              markerId: MarkerId("D$i"),
              position:
                  LatLng(middlePosition.latitude, middlePosition.longitude),
              // infoWindow: InfoWindow(title: "DISTANCE"),
              icon: customMarkerIcon);
          //MapUtils.markerToShow.add(dMarker);

          _markerMap.add(dMarker);
        }
      }

      // je supprime le dernier point ajouté pour former la boucle
      // if (paths.length > 2) {
      //   paths.removeLast();
      // }
    });
  }

// fonctions pour la détermination du centre du polygone
  LatLng _polygonCenter() {
    double latSum = 0.0;
    double lngSum = 0.0;

    for (LatLng point in paths) {
      latSum += point.latitude;
      lngSum += point.longitude;
    }

    return LatLng(latSum / paths.length, lngSum / paths.length);
  }

  void _fitBounds() {
    LatLngBounds bounds = _getPolygonBounds();
    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
  }

  LatLngBounds _getPolygonBounds() {
    double minLat = double.infinity;
    double minLng = double.infinity;
    double maxLat = -double.infinity;
    double maxLng = -double.infinity;

    for (LatLng point in paths) {
      minLat = math.min(minLat, point.latitude);
      minLng = math.min(minLng, point.longitude);
      maxLat = math.max(maxLat, point.latitude);
      maxLng = math.max(maxLng, point.longitude);
    }

    return LatLngBounds(
      northeast: LatLng(maxLat, maxLng),
      southwest: LatLng(minLat, minLng),
    );
  }

  /// recuperer le perimètre
  double getSurface() {
    List<mp.LatLng> newPath = paths
        .map(
          (e) => mp.LatLng(e.latitude, e.longitude),
        )
        .toList();
    return mp.SphericalUtil.computeArea(newPath).toDouble();
  }

  /// capturer le container en IMAGE
  Future<Uint8List> captureContainer() async {
    try {
      // Find the RenderRepaintBoundary for the given GlobalKey
      RenderRepaintBoundary boundary = containerKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      // Capture the image
      ui.Image image = await boundary.toImage(
          pixelRatio: 3.0); // Adjust pixelRatio as needed

      // Convert the image to bytes
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List uint8List = byteData!.buffer.asUint8List();

      return uint8List;
    } catch (e) {
      print('Error capturing container: $e');
      return Uint8List(0);
    }
  }

  @override
  void initState() {
    if (widget.paths != null) {
      widget.paths!.add(widget.paths![0]);
    }

    paths = widget.paths ??
        [
          LatLng(5.2800899816145135, -4.1450368613004684),
          LatLng(5.280310992566902, -4.141850396990776),
          LatLng(5.2830045154847465, -4.142181985080242),
          LatLng(5.2827965257211495, -4.143986776471138),
          LatLng(5.281315222608827, -4.144642241299152),
          LatLng(5.281318227284025, -4.145294688642025),
          LatLng(5.2800899816145135, -4.1450368613004684),
        ];
    log(getSurface().toString(), name: 'surface');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    () async {
      await _addMarkers();
      //_markerMap.addAll(_markerMap);
      await _addDistance();
    }()
        .then((value) => setState(
              () {},
            ));
    openPoints = MapFunctions.convertToLatLng2(paths);
    super.initState();
  }

  @override
  void dispose() {
    _markerMap.clear();
    _markers.clear();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintBoundary(
        key: containerKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 4,
                            child: Stack(children: [
                              GoogleMap(
                                zoomGesturesEnabled: true,
                                rotateGesturesEnabled: true,
                                scrollGesturesEnabled: true,
                                tiltGesturesEnabled: true,
                                compassEnabled: true,
                                zoomControlsEnabled: true,
                                myLocationButtonEnabled: false,
                                mapType: MapType.hybrid,
                                onMapCreated: (controller) {
                                  mapController = controller;
                                },
                                initialCameraPosition: CameraPosition(
                                  target: _polygonCenter(),
                                  zoom:
                                      mapZoom, //getSurface() * 0.000193,markers: _markerMap,
                                ),
                                markers: _markerMap,
                                polygons: {
                                  Polygon(
                                    geodesic: true,
                                    polygonId: PolygonId('myPolygon'),
                                    points: paths,
                                    fillColor: Colors.blue.withOpacity(0.5),
                                    strokeColor: Colors.blue,
                                    strokeWidth: 2,
                                  ),
                                },
                              ),
                              Positioned(
                                  child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(border: Border.all()),
                                child: SimpleMap(
                                  points: openPoints,
                                  center: opens.LatLng(
                                      _polygonCenter().latitude,
                                      _polygonCenter().longitude),
                                ),

                                // GoogleMap(
                                //   zoomGesturesEnabled: false,
                                //   rotateGesturesEnabled: false,
                                //   scrollGesturesEnabled: false,
                                //   tiltGesturesEnabled: false,
                                //   myLocationButtonEnabled: false,
                                //   mapType: MapType.hybrid,
                                //   onMapCreated: (controller) {
                                //     secondMapController = controller;
                                //   },
                                //   initialCameraPosition: CameraPosition(
                                //     target: _polygonCenter(),
                                //     zoom: 13, //getSurface() * 0.000158,
                                //   ),
                                //   polygons: {
                                //     Polygon(
                                //       geodesic: true,
                                //       polygonId: PolygonId('myPolygon'),
                                //       points: paths,
                                //       fillColor: Colors.blue.withOpacity(0.5),
                                //       strokeColor: Colors.blue,
                                //       strokeWidth: 2,
                                //     ),
                                //   },
                                // ),
                              ))
                            ]),
                          ),
                          Flexible(
                            flex: 2,
                            child: ListView(
                              children: [
                                Container(
                                  // height: MediaQuery.of(context).size.height,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DataTable(
                                        headingRowHeight: 50,
                                        headingRowColor:
                                            MaterialStatePropertyAll<Color>(
                                                CupertinoColors.white),
                                        columns: [
                                          DataColumn(label: Text('Bornes')),
                                          DataColumn(
                                            label: Text('X'),
                                          ),
                                          DataColumn(label: Text('Y')),
                                          // DataColumn(label: Text('ANOLES')),
                                          // DataColumn(label: Text('DISTANCES')),
                                        ],
                                        rows: _markers
                                            .map<DataRow>((e) => DataRow(
                                                  color:
                                                      MaterialStateProperty.all(
                                                          Colors.grey[300]),
                                                  cells: [
                                                    DataCell(Text(
                                                        e.infoWindow.title ??
                                                            'KO')),
                                                    DataCell(Text(UTM
                                                        .fromLatLon(
                                                            lat: e.position
                                                                .latitude,
                                                            lon: e.position
                                                                .longitude)
                                                        .easting
                                                        .toStringAsFixed(3))),
                                                    DataCell(Text(UTM
                                                        .fromLatLon(
                                                            lat: e.position
                                                                .latitude,
                                                            lon: e.position
                                                                .longitude)
                                                        .northing
                                                        .toStringAsFixed(3))),
                                                    // DataCell(Text('')),
                                                    // DataCell(Text('')),
                                                  ],
                                                ))
                                            .toList(),
                                      ),
                                      Container(
                                          width: 100,
                                          //padding: EdgeInsets.only(top: 3),
                                          //height: double.infinity,
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Container(
                                                color: Colors.white,
                                                height: 51,
                                                child: Center(
                                                    child: Text('DISTANCES')),
                                              ),
                                              for (int i = 0;
                                                  i < distances.length;
                                                  i++)
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    border: Border(
                                                        bottom: BorderSide(
                                                      color: Colors.white,
                                                    )),
                                                  ),
                                                  height: (i == 0) ? 70.9 : 50,
                                                  child: Center(
                                                      child:
                                                          Text(distances[i])),
                                                ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      child: ClipRect(
                        // <-- clips to the 200x200 [Container] below
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(
                            sigmaX: 5.0,
                            sigmaY: 5.0,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 1500,
                            height: 1000,
                            child: Container(
                              width: 330,
                              height: 320,
                              padding: EdgeInsets.all(5).copyWith(top: 10),
                              decoration: BoxDecoration(
                                  color: CupertinoColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      color: Colors.grey,
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.lock_clock,
                                    size: 40,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                  Text(
                                    'Veuillez régler la facture pour pouvoir voir entièrement la delimitation de ce champ avec les bornes, des distances entre les bornes, le tableau et enregistrer le document.',
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '3000 FCFA',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      log("HELLO");
                                    },
                                    child: Text(
                                      'Payer maintenant',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
/*      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  mapController.animateCamera(CameraUpdate.zoomIn());
                  //secondMapController.animateCamera(CameraUpdate.zoomIn());
                  //mapZoom += 0.5;
                });
              },
              child: Icon(Icons.add),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  //secondMapController.animateCamera(CameraUpdate.zoomOut());
                  mapZoom -= 0.2;
                  mapController.animateCamera(CameraUpdate.zoomOut());
                });
              },
              child: Icon(Icons.minimize),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {});
            },
            child: Icon(Icons.download),
          ),
        ],
      ),
   */ );
  }
}
