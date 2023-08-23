import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../bloc/map_state.dart';
import '../bloc/map_utils.dart';

class TextFieldMap extends StatelessWidget {
  TextFieldMap({super.key, required this.textEditingController});
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 55,
        top: 15,
        child: ValueListenableBuilder<MODEDELIMITE>(
          valueListenable: MapUtils.mapNotifier,
          builder: (context, value, child) => (value == MODEDELIMITE.map)
              ? SizedBox(
                  height: 40,
                  width: 285,
                  child: GooglePlaceAutoCompleteTextField(
                      textEditingController: textEditingController,
                      googleAPIKey: "AIzaSyD0OFIF-WwrQRVpD3acbegQoIGapwtkAOk",
                      inputDecoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_city_rounded),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: CupertinoColors.black,
                              ),
                              borderRadius: BorderRadius.circular(30)),
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Rechercher un lieux...",
                          hintStyle: TextStyle(),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30)),
                          fillColor: Colors.white,
                          filled: true),
                      debounceTime: 800, // default 600 ms,
                      countries: const [
                        "ci",
                        "fr"
                      ], // optional by default null is set
                      isLatLngRequired:
                          true, // if you required coordinates from place detail
                      getPlaceDetailWithLatLng: (Prediction prediction) {
                        FocusScope.of(context).requestFocus(FocusNode());

                        MapUtils.mapController!.animateCamera(
                          CameraUpdate.newLatLng(
                            LatLng(
                              double.parse(prediction.lat!),
                              double.parse(prediction.lng!),
                            ),
                          ),
                        );

                        // onSerachAddMaker(LatLng(double.parse(prediction.lat!),
                        //     double.parse(prediction.lng!)));
                        // print("placeDetails" + prediction.lng.toString());
                      }, // this callback is called when isLatLngRequired is true
                      itmClick: (Prediction prediction) {
                        textEditingController.text = prediction.description!;
                        textEditingController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: prediction.description!.length));
                        MapUtils.mapUtilsFunctions.clearPoints();
                        textEditingController.clear();
                      }),
                )
              : SizedBox(),
        ));
  }
}
