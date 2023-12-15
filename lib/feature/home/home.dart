import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greenmind/configs/constants.dart';
import 'package:greenmind/cubit/field_cubit.dart';
import 'package:greenmind/feature/delimitation/bloc/map_bloc.dart';
import 'package:greenmind/feature/home/bloc/home_navigation_cubit.dart';
import 'package:greenmind/feature/home/widgets/home_drawer.dart';
import 'package:greenmind/maplib/maplib.dart';
import 'package:flutter/cupertino.dart';
import 'package:greenmind/utils/app_dialog.dart';
import 'package:greenmind/utils/form_utils.dart';
import 'package:greenmind/widgets/custom_text_field.dart';
import '../../cubit/app_states/app_state.dart';
import '../../sized_config.dart';
import '../../widgets/custom_loading_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

  static String routeName = "/home";
}

class _HomeState extends State<Home> {
  FocusNode focusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _fieldNameController = TextEditingController();
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
                  //inspect(MapUtils.path);

                  //log(MapUtils.path.toString(), name: 'PATHS');

                  /*MapDisplayFunction(context: context)
                      .displayPopupInfo(context: context);*/

                  if (MapUtils.path.length < 3) {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: const Icon(
                          CupertinoIcons.exclamationmark_triangle,
                          color: CupertinoColors.systemRed,
                        ),
                        content: const Text(
                            'Vous devez placer au moins trois bornes pour former le polygone'),
                        actions: <CupertinoDialogAction>[
                          CupertinoDialogAction(
                            /// This parameter indicates this action is the default,
                            /// and turns the action's text to bold text.
                            isDefaultAction: true,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                          // CupertinoDialogAction(
                          //   /// This parameter indicates the action would perform
                          //   /// a destructive action such as deletion, and turns
                          //   /// the action's text color to red.
                          //   isDestructiveAction: true,
                          //   onPressed: () {
                          //     Navigator.pop(context);
                          //   },
                          //   child: const Text('Yes'),
                          // ),
                        ],
                      ),
                    );
                  }else{
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // Retourne l'objet AlertDialog
                        return BlocBuilder<FieldCubit, AppState>(
                          bloc: FieldCubit(),
                          builder: (context, state) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              content: (state is PendingState)
                                  ? Center(
                                child: CupertinoActivityIndicator(),
                              )
                                  : (state is FinishState<bool>)
                                  ? Center(
                                child: (state.data)
                                    ? Text('Terrain créé')
                                    : Text('Terrain échoué'),
                              )
                                  : SizedBox(
                                height: 100,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                        validator: (value) =>
                                            FormUtils.fieldValidator(
                                                value: value),
                                        controller:
                                        _fieldNameController,
                                        labelText: 'nom du terrain',
                                        textInputAction:
                                        TextInputAction.done,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                CustomLoadingButtom(
                                  isLoading: (state is PendingState),
                                  onClick: ((state is PendingState))
                                      ? null
                                      : () {
                                    if (_formKey.currentState!.validate()) {
                                      context
                                          .read<FieldCubit>()
                                          .createField(
                                          fieldname:
                                          _fieldNameController.text,
                                          polygone: MapUtils.path,
                                          context: context);
                                    }

                                    //context.go('/homePage');
                                  },
                                  text: 'ENREGISTRER',
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ).then((value) async {
                      await MapFunctions(context: context).clearPoint();
                      context.read<MapBloc>().add(SendPositionEvent());
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          icon: Icon(
                            CupertinoIcons.checkmark_alt_circle,
                            size: 30,
                            color: CupertinoColors.systemGreen,
                          ),
                          content: Container(
                            height: 100,
                            child: Center(
                              child: Text('Le terrain a été créé avec succès'),
                            ),
                          ),
                        ),
                      );
                    });
                  }

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
