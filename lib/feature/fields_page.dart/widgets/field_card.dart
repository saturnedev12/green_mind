import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greenmind/data/models/firebase_field.dart';
import 'package:greenmind/feature/map/simple_map.dart';
import 'package:greenmind/maplib/maplib.dart';
import 'package:greenmind/services/firestore_services.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;

class FieldCard extends StatefulWidget {
  const FieldCard({super.key, required this.field});
  final FireBaseField field;


  @override
  State<FieldCard> createState() => _FieldCardState();
}

class _FieldCardState extends State<FieldCard> {
  late final surface;
  @override
  void initState() {
     surface = mp.SphericalUtil.computeArea(FireStoreServices.createListeFromCordinate3(widget.field.polygone!));

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return      Container(
      width: 350,
      height: 330,
      //margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: Offset.zero,
              blurRadius: 10,
              spreadRadius: 0.5,
            )
          ]),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                child: SimpleMap(
                  points: FireStoreServices.createListeFromCordinate2(
                      widget.field.polygone!),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: SizedBox(
                  child: CupertinoButton(
                    color: CupertinoColors.white,
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(60),
                    child: TextButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.arrow_outward_rounded),
                        label: Text('0.17')),
                    onPressed: () {
                      context.go('/polygonal',
                          extra: FireStoreServices.createListeFromCordinate(
                              widget.field.polygone!));
                    },
                  ),
                ),
              )
            ],
          ),
          const Expanded(child: SizedBox()),
          Row(
            children: [
              Expanded(
                child: Container(
                  //color: Colors.red,
                  width: 300,
                  height: 40,
                  child: CupertinoListTile(
                    padding: EdgeInsets.zero,
                    title: Text(widget.field.fieldname ?? 'Pas de nom'),
                    subtitle: Text('Récolte le 23 Mai'),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Récolte'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.crop_outlined,
                          size: 15,
                        ),
                        SizedBox(width: 10,),
                        Text(MapDisplayFunction(context: context).convertSurface(surface)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );

  }
}


