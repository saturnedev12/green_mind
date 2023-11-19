import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:greenmind/data/bloc/create_field_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../Utils.dart';
import '../../data/models/address.dart';
import '../../services/locationService.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
  static String routeName = "/map";
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _googleMapController;

  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor markerBitMap = BitmapDescriptor.defaultMarker;
  final markers = Set<Marker>();
  MarkerId markerId = const MarkerId("tesy");
  LatLng latLng = const LatLng(43.2994, 74.2179);
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _fieldNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<List<double>>? latLngArray;
  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  DateTime dateTime = DateTime.now();

  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = HashSet<Polygon>();
  final Set<Polyline> _polyLines = HashSet<Polyline>();
  bool _drawPolygonEnabled = false;
  List<LatLng> _points = [];
  bool _clearDrawing = false;
  int? _lastXCoordinate, _lastYCoordinate;

  int index = 0;

  List<String> liste1 = [
    "Olive tree",
    "Pasture",
    "Poppy seed",
    "Cherry",
    "Summer fallow",
    "Cassava",
    "Ginger",
    "Yams",
    "Kola nut",
    "Millet",
    "Plantain",
    "Bananas",
    "Sesame",
    "Milk thistle",
    "Cashew",
    "Gum arabic",
    "Melon",
    "Oil palm",
    "Rubber",
    "Turmeric",
    "Wheat",
    "Grapes",
    "Vegetables",
    "Beans",
    "Nuts",
    "Almonds",
    "Potatoes",
    "Rye",
    "Rapeseed",
    "Corn",
    "Sugar Beet",
    "Sunflower",
    "Soybeans",
    "Peas",
    "Oats",
    "Mixed cereals",
    "Cotton",
    "Flax",
    "Rice",
    "Pulses",
    "Coffee",
    "Cocoa",
    "Tobacco",
    "Tuber crops",
    "Citrus",
    "Sugarcane",
    "Canola",
    "Alfalfa",
    "Fruit",
    "Apple",
    "Spice",
    "Peanuts",
    "Other",
    "Spring Cereals",
    "Spring Barley",
    "Winter Rapeseed",
    "Winter Barley",
    "Spring Rapeseed",
    "Winter Cereals",
    "Sorghum",
    "Winter Sorghum",
    "Winter Wheat",
    "Buckwheat",
    "Oilseed Crops",
    "Cereal"
  ];

  List<String> liste2 = [
    "Olivier",
    "Pâturage",
    "Graine de pavot",
    "Cerise",
    "Jachère d'été",
    "Manioc",
    "Gingembre",
    "ignames",
    "Noix de kola",
    "Millet",
    "Banane plantain",
    "Bananes",
    "Sésame",
    "Chardon Marie",
    "Anacardier",
    "La gomme arabique",
    "Melon",
    "Huile de palme",
    "Caoutchouc",
    "Curcuma",
    "Blé",
    "Raisins",
    "Légumes",
    "Haricots",
    "Des noisettes",
    "Amandes",
    "Patates",
    "Seigle",
    "Colza",
    "Maïs",
    "Betterave à sucre",
    "Tournesol",
    "Soja",
    "Petits pois",
    "Avoine",
    "Mélange de céréales",
    "Coton",
    "Lin",
    "Riz",
    "Légumineuses",
    "Café",
    "Cacao",
    "Le tabac",
    "Agrumes",
    "Canne à sucre",
    "Canola",
    "Luzerne",
    "Fruit",
    "Pomme",
    "Pimenter",
    "Cacahuètes",
    "Autre",
    "Céréales de printemps",
    "Orge de printemps",
    "Colza d'hiver",
    "Orge d'hiver",
    "Céréales d'hiver",
    "Sorgho",
    "Sorgho d'hiver",
    "Blé d'hiver",
  ];

  @override
  void initState() {
    LocationService.instance?.requestAndCheckPermission();

    markers.add(
      Marker(
        markerId: markerId,
        position: latLng,
      ),
    );
    super.initState();
  }

  void addCustomMarker() async {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/images/location.png")
        .then((value) => {
              setState(() {
                markerBitMap = value;
              })
            });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: GooglePlaceAutoCompleteTextField(
                textEditingController: _placeController,
                googleAPIKey: "AIzaSyD0OFIF-WwrQRVpD3acbegQoIGapwtkAOk",
                inputDecoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Rechercher un lieux...",
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.white,
                    filled: true),
                debounceTime: 800, // default 600 ms,
                countries: ["ci", "fr"], // optional by default null is set
                isLatLngRequired:
                    true, // if you required coordinates from place detail
                getPlaceDetailWithLatLng: (Prediction prediction) {
                  // this method will return latlng with place detail
                  print(prediction.lat);
                  print(prediction.lng);
                  _googleMapController.animateCamera(CameraUpdate.newLatLng(
                      LatLng(double.parse(prediction.lat!),
                          double.parse(prediction.lng!))));
                  onSerachAddMaker(LatLng(double.parse(prediction.lat!),
                      double.parse(prediction.lng!)));
                  print("placeDetails" + prediction.lng.toString());
                }, // this callback is called when isLatLngRequired is true
                itmClick: (Prediction prediction) {
                  _placeController.text = prediction.description!;
                  _placeController.selection = TextSelection.fromPosition(
                      TextPosition(offset: prediction.description!.length));
                }),
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Colors.transparent,

              // Status bar brightness (optional)
              statusBarIconBrightness:
                  Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            toolbarHeight: 100,
            backgroundColor: Colors.transparent,
          ),
          body: GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.satellite,
            initialCameraPosition: _kGooglePlex,
            polygons: _polygons,
            markers: _markers,
            polylines: _polyLines,
            onTap: (latLng) {
              onTapAddMaker(latLng);
            },
            onMapCreated: (GoogleMapController controller) {
              _googleMapController = controller;

              _controller.complete(controller);
            },
          ),
        ),
        Positioned(right: 40, bottom: 20, child: buildFAB()),
        Positioned(right: 40, bottom: 80, child: buildDraw()),
        Visibility(
            visible: _drawPolygonEnabled,
            child: Positioned(right: 40, bottom: 140, child: buildValidate())),
      ],
    );
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

  void onSerachAddMaker(LatLng latLng) async {
    if (!_drawPolygonEnabled) {
      _markers.clear();
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId("1"),
            position: latLng,
            infoWindow: InfoWindow(snippet: _placeController.text),
            icon: BitmapDescriptor.defaultMarker,
            onTap: () {}));
      });
    }
  }

  void onTapAddMaker(LatLng latLng) async {
    var uuid = const Uuid();
    final _markerIcon =
        await getBytesFromAsset("assets/images/ic_pick.png", 100);

    if (_drawPolygonEnabled) {
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId(uuid.v4().toString()),
            position: latLng,
            infoWindow: InfoWindow(
                title: (_points.length + 1).toString(),
                snippet: "juste un test"),
            icon: BitmapDescriptor.fromBytes(_markerIcon),
            onTap: () {}));
        _points.add(latLng);
        updatePolygon();
      });
    }
  }

  updatePolygon() {
    var uuid = const Uuid();

    _polygons.add(
      Polygon(
          polygonId: PolygonId(uuid.v4().toString()),
          points: _points,
          fillColor: Colors.green.withOpacity(0.1),
          strokeColor: Colors.green,
          strokeWidth: 4),
    );
  }

  _toggleDrawing() {
    _clearPolygons();
    setState(() => _drawPolygonEnabled = !_drawPolygonEnabled);
  }

  List<List<double>> convertToLatLngArray(List<LatLng> latLngList) {
    LatLng firstLatLng = latLngList.first;
    latLngList[latLngList.length - 1] = firstLatLng;
    print("voici lat");
    print(firstLatLng);
    List<List<double>> result = [];

    for (LatLng latLng in latLngList) {
      result.add([latLng.longitude, latLng.latitude]);
    }

    return result;
  }

  _clearPolygons() {
    setState(() {
      _polyLines.clear();
      _polygons.clear();
      _points.clear();
      _markers.clear();
    });
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

  Future<String?> openDialog() => showDialog(
      context: context,
      builder: (context) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.height * 0.5,
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.flag,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Détails sur la culture",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Nom du champs",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "ce champs ne doit pas être vide";
                                }

                                return null;
                              },
                              controller: _fieldNameController,
                              autofocus: false,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: "Tapez le nom du champs",
                                hintStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Type de culture",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: TextFormField(
                                    controller: _typeController,
                                    onTap: () => Utils.showSheet(
                                      context,
                                      child: buildCustomPicker(),
                                      onClicked: () {
                                        final value = liste1[index];
                                        _typeController.text = value;
                                        Navigator.pop(context);
                                      },
                                    ),
                                    autofocus: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "ce champs ne doit pas être vide";
                                      }

                                      return null;
                                    },
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      hintText:
                                          "Tapez le type de culture de votre champs",
                                      suffixIcon:
                                          const Icon(Icons.arrow_drop_down),
                                      hintStyle: TextStyle(color: Colors.grey),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      contentPadding: EdgeInsets.all(10),
                                      border: InputBorder.none,
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date de la semence",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "ce champs ne doit pas être vide";
                                      }

                                      return null;
                                    },
                                    controller: _dateController,
                                    onTap: () => Utils.showSheet(
                                      context,
                                      child: buildDatePicker(),
                                      onClicked: () {
                                        final value = DateFormat('yyyy-MM-dd')
                                            .format(dateTime);
                                        _dateController.text = value;
                                        Navigator.pop(context);
                                      },
                                    ),
                                    autofocus: false,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(Icons.arrow_drop_down),
                                        hintText:
                                            "Tapez la date de la semence pour cette culture",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.green),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        contentPadding: EdgeInsets.all(10),
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        errorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(child: BlocBuilder<CreateFieldBloc, CreateFieldState>(
                    builder: (context, state) {
                      if (state is CreateFieldLoading) {
                        return MaterialButton(
                          onPressed: () {},
                          child: activityIndicatorOs(),
                          color: Colors.green,
                        );
                      } else {
                        return MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              latLngArray = convertToLatLngArray(_points);

                              print("object");
                              print(latLngArray);
                              context.read<CreateFieldBloc>().add(
                                  CreateNewField(
                                      name: _fieldNameController.text,
                                      coordinates: latLngArray!,
                                      cropType: _typeController.text,
                                      sowingDate: _dateController.text,
                                      year: _dateController.text
                                          .substring(0, 4)));
                            }
                          },
                          child: Text(
                            "Créer",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          color: Colors.green,
                        );
                      }
                    },
                  ))
                ],
              ),
            ),
          )));
  Widget activityIndicatorOs() {
    if (Platform.isIOS) {
      return const CupertinoActivityIndicator();
    }
    return const CircularProgressIndicator(color: Colors.white);
  }

  Widget buildDatePicker() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          minimumYear: 2015,
          maximumYear: DateTime.now().year,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );

  Widget buildCustomPicker() => SizedBox(
        height: 300,
        child: CupertinoPicker(
          itemExtent: 64,
          diameterRatio: 0.7,
          looping: true,
          onSelectedItemChanged: (index) => setState(() => this.index = index),
          // selectionOverlay: Container(),
          selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
            background: Colors.green.withOpacity(0.12),
          ),
          children: Utils.modelBuilder<String>(
            liste1,
            (index, value) {
              final isSelected = this.index == index;
              final color = isSelected ? Colors.green : Colors.black;

              return Center(
                child: Text(
                  value,
                  style: TextStyle(color: color, fontSize: 24),
                ),
              );
            },
          ),
        ),
      );

  Widget buildFAB() => FloatingActionButton(
        heroTag: "btn1",
        backgroundColor: Colors.white,
        child: Icon(
          Icons.gps_fixed,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () async {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best);

          final address = await getAddressFromCoodinate(
              LatLng(position.latitude, position.longitude));
          LocationService.instance?.getCurrentPosition(address);
          _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(
                      address.latLng!.latitude, address.latLng!.longitude),
                  zoom: 15)));
          setState(() {});
        },
      );
  Widget buildDraw() => FloatingActionButton(
        heroTag: "btn2",
        backgroundColor: Colors.green,
        onPressed: _toggleDrawing,
        child: _drawPolygonEnabled
            ? Icon(
                Icons.delete,
                size: 40,
                color: Colors.white,
              )
            : Icon(
                Icons.edit,
                size: 40,
                color: Colors.white,
              ),
      );
  Widget buildValidate() => FloatingActionButton(
      heroTag: "btn3",
      backgroundColor: Colors.green,
      onPressed: openDialog,
      child: Icon(
        Icons.check,
        size: 40,
        color: Colors.white,
      ));
}
