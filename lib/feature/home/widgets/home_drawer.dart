import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenmind/Utils.dart';

import '../bloc/home_navigation_cubit.dart';
import 'home_listtile.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavigationCubit, PageState>(
      builder: (context, state) => Container(
        width: 400,
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"),
                        fit: BoxFit.cover)),
              ),
            ),
            HomeListTile(
              isSelected: state.pageIndex == PageIndex.HOME,
              onTap: () => context
                  .read<HomeNavigationCubit>()
                  .onNavigate(pageIndex: PageIndex.HOME),
              icon: CupertinoIcons.home,
              title: 'Home',
            ),
            HomeListTile(
              isSelected: state.pageIndex == PageIndex.ANALYSE,
              onTap: () => context
                  .read<HomeNavigationCubit>()
                  .onNavigate(pageIndex: PageIndex.ANALYSE),
              icon: CupertinoIcons.chart_pie,
              title: 'Analyses',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100.0),
              child: ListTile(title: Text("")),
            ),
            // HomeListTile(
            //   isSelected: state.pageIndex == PageIndex.SETTINGS,
            //   onTap: context
            //       .read<HomeNavigationCubit>()
            //       .onNavigate(pageIndex: PageIndex.SETTINGS),
            //   icon: CupertinoIcons.settings,
            //   title: 'Reglage',
            // ),
            // HomeListTile(
            //   isSelected: false,
            //   onTap: context
            //       .read<HomeNavigationCubit>()
            //       .onNavigate(pageIndex: PageIndex.SETTINGS),
            //   icon: CupertinoIcons.question_circle,
            //   title: 'Info',
            // ),
            // HomeListTile(
            //   isSelected: false,
            //   onTap: context
            //       .read<HomeNavigationCubit>()
            //       .onNavigate(pageIndex: PageIndex.SETTINGS),
            //   icon: Icons.exit_to_app,
            //   title: 'Deconnexion',
            // ),
          ],
        ),
      ),
    );
  }
}
