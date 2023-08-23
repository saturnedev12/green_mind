import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../bloc/map_bloc.dart';
import '../bloc/map_state.dart';
import '../bloc/map_utils.dart';

class MapAppBar extends StatelessWidget implements PreferredSizeWidget {
  MapAppBar({super.key});

  Map<MODEDELIMITE, Widget> modes = {
    MODEDELIMITE.browse: const Icon(
      Icons.directions_walk,
      size: 15,
    ),
    MODEDELIMITE.stake: Icon(
      Icons.flag,
      size: 15,
    ),
    MODEDELIMITE.map: Icon(
      Icons.map_rounded,
      size: 15,
    ),
  };
  //MODEDELIMITE selectedMode = MODEDELIMITE.browse;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MODEDELIMITE>(
      valueListenable: MapUtils.mapNotifier,
      builder: (context, value, child) => AppBar(
        // Définissez ici les propriétés de votre AppBar personnalisée
        //title: Text('Mon AppBar personnalisée'),
        // Autres propriétés...
        actions: [
          PopupMenuButton<MODEDELIMITE>(
            initialValue: value,
            child: SizedBox(
              //width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_drop_down_outlined),
                  Text(
                    'MODE:',
                    style: TextStyle(color: CupertinoColors.black),
                  ),
                  modes[MapUtils.mapNotifier.value]!,
                ],
              ),
            ),
            onSelected: (value) async {
              await Future.sync(() {
                MapUtils.mapNotifier.value = value;
              });

              context.read<MapBloc>().add(SendPositionEvent());
            },
            itemBuilder: (BuildContext context) {
              return [
                // const PopupMenuItem<MODEDELIMITE>(
                //   value: MODEDELIMITE.browse,
                //   child: CupertinoListTile(
                //     leading: Icon(Icons.directions_walk),
                //     title: Text('Parcourir'),
                //   ),
                // ),
                const PopupMenuItem<MODEDELIMITE>(
                  value: MODEDELIMITE.stake,
                  child: CupertinoListTile(
                    leading: Icon(Icons.flag),
                    title: Text('Piquets'),
                  ),
                ),
                const PopupMenuItem<MODEDELIMITE>(
                  value: MODEDELIMITE.map,
                  child: CupertinoListTile(
                    leading: Icon(Icons.map_rounded),
                    title: Text('Sur map'),
                  ),
                ),
              ];
            },
          ),
          // IconButton(
          //     onPressed: () {
          //       MapUtils.undoPoint(context: context);
          //       context.read<MapBloc>().add(SendPositionEvent());
          //     },
          //     icon: CircleAvatar(child: Icon(CupertinoIcons.arrow_uturn_left))),
          IconButton(
            onPressed: () {
              MapUtils.mapUtilsFunctions.rollBackPoint(context: context);
              context.read<MapBloc>().add(SendPositionEvent());
            },
            icon: const CircleAvatar(
                child: Icon(
              CupertinoIcons.arrow_uturn_right,
              size: 18,
            )),
          ),
          IconButton(
            onPressed: () {
              MapUtils.mapUtilsFunctions.clearPoints();
              context.read<MapBloc>().add(SendPositionEvent());
            },
            icon: const CircleAvatar(
                child: Icon(
              CupertinoIcons.repeat,
              size: 18,
            )),
          ),
          TextButton(
              onPressed: () async {
                MapUtils.mapUtilsFunctions.displayPopupInfo(context: context);
                // await MapUtils.addDistance(context: context);
                // context.read<MapBloc>().add(SendPositionEvent());
              },
              child: Text('Terminer')),
          IconButton(
            onPressed: () async {
              await Future.sync(() {
                List<Marker> _markers = List.from(MapUtils.markers);
                print(_markers);
              });
            },
            icon: const Icon(CupertinoIcons.question_circle_fill),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40);
}
