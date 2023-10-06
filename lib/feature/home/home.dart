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
      ),
    );
  }
}
