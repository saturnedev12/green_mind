import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenmind/configs/constants.dart';
import 'package:greenmind/feature/delimitation/bloc/map_bloc.dart';
import 'package:greenmind/feature/home/bloc/home_navigation_cubit.dart';
import 'package:greenmind/feature/home/widgets/home_drawer.dart';
import 'package:greenmind/maplib/maplib.dart';
import 'package:flutter/cupertino.dart';
import '../../sized_config.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

  static String routeName = "/home";
}

class _HomeState extends State<Home> {
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const HomeDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        //leadingWidth: 125,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.menu_rounded,
                )),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        }),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await MapFunctions(context: context).rollBack();
              context.read<MapBloc>().add(SendPositionEvent());
            },
            icon: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(
                  CupertinoIcons.arrow_uturn_right,
                  size: 18,
                )),
          ),
          IconButton(
            onPressed: () async {
              await MapFunctions(context: context).clearPoint();
              context.read<MapBloc>().add(SendPositionEvent());
            },
            icon: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(
                  CupertinoIcons.repeat,
                  size: 18,
                )),
          ),
          SizedBox(
            height: 30,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    textStyle: TextStyle(
                      color: Colors.white,
                    )),
                onPressed: () async {
                  // context.read<MapBloc>().add(SendPositionEvent());
                  // inspect(MapUtils.markers);
                  // log(MapUtils.markers.toString(), name: 'All markers');
                  // log(MapUtils.markerToShow.toString(), name: 'Marker to show');
                  // log(MapUtils.polygons.first.points.toString(),
                  //     name: 'Polygone');
                  // log(MapUtils.polylines.first.points.toString(),
                  //     name: 'polylines');
                  log(MapUtils.path.toString(), name: 'PATHS');
                  MapDisplayFunction(context: context)
                      .displayPopupInfo(context: context);
                },
                child: TextButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.save_alt_rounded,
                    size: 18,
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  label: Text(
                    'Enregistrer',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )),
          ),
          // IconButton(
          //   onPressed: () async {
          //     await Future.sync(() {
          //       List<Marker> _markers = List.from(MapUtils.markers);
          //       print(_markers);
          //     });
          //   },
          //   icon: const Icon(CupertinoIcons.question_circle_fill),
          // ),
          Material(
            shape: CircleBorder(side: BorderSide(color: Colors.green)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
              child: Ink.image(
                image: NetworkImage(
                    'https://imageio.forbes.com/specials-images/imageserve/5f6a779460548326baf6d730/960x0.jpg?format=jpg&width=960'),
                height: 30,
                width: 30,
              ),
            ),
          ),
        ],
        toolbarHeight: 48,
      ),
      body: BlocBuilder<HomeNavigationCubit, PageState>(
        builder: (context, state) =>
            ConstantsApp.listPages[state.pageIndex] ??
            Container(
              color: Colors.red,
            ),
      ),
    );
  }
}
