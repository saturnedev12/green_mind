import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenmind/configs/constants.dart';
import 'package:greenmind/feature/home/bloc/home_navigation_cubit.dart';
import 'package:greenmind/feature/home/widgets/home_drawer.dart';

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

    return SafeArea(
      child: Scaffold(
        drawer: const HomeDrawer(),
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
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
          toolbarHeight: 30,
        ),
        body: BlocBuilder<HomeNavigationCubit, PageState>(
          builder: (context, state) =>
              ConstantsApp.listPages[state.pageIndex] ??
              Container(
                color: Colors.red,
              ),
        ),
        //  Column(
        //   children: <Widget>[
        //     Expanded(
        //       child: Row(
        //         mainAxisSize: MainAxisSize.max,
        //         crossAxisAlignment: CrossAxisAlignment.stretch,
        //         children: <Widget>[
        //           Flexible(
        //             flex: 3,
        //             child: BlocBuilder<HomeNavigationCubit, PageState>(
        //               builder: (context, state) =>
        //                   ConstantsApp.listPages[state.pageIndex] ??
        //                   Container(
        //                     color: Colors.red,
        //                   ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

/*
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Bienvenue,",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Text("Aaron", style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ],
                      ),
                      Material(
                        shape:
                            CircleBorder(side: BorderSide(color: Colors.green)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          child: Ink.image(
                            image: NetworkImage(
                                'https://imageio.forbes.com/specials-images/imageserve/5f6a779460548326baf6d730/960x0.jpg?format=jpg&width=960'),
                            height: 70,
                            width: 70,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed("/map"),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.53,
                        child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(20),
                            dashPattern: [10, 10],
                            color: Colors.grey,
                            strokeWidth: 2,
                            child: Card(
                              elevation: 0,
                              color: Colors.lightGreen.shade50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 70,
                                  ),
                                  Text('Ajouter un nouveau champs')
                                ],
                              )),
                            ))),
                  )
                ],
              ),
            ),
          ),
        
*/


