import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenmind/configs/constants.dart';

class MeteoBox extends StatelessWidget {
  const MeteoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              spreadRadius: 2,
              color: Colors.grey[500]!,
            ),
          ]),
      width: 350,
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Scaffold(
          appBar: AppBar(
            //toolbarHeight: 50,
            backgroundColor: HexColor.fromHex("#00BFFF"),
            leadingWidth: 200,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Champs de manioc',
                      ),
                      Icon(
                        CupertinoIcons.location,
                        size: 10,
                      )
                    ],
                  ),
                  Text(
                    '25˚',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),

            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    Icon(
                      Icons.sunny,
                      color: Colors.yellow,
                    ),
                    Text("Ensoleillé"),
                    Text("tptp"),
                  ],
                ),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  HexColor.fromHex("#ADD8E6"),
                  HexColor.fromHex("#00BFFF")
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(children: [
              for (int i = 0; i < 5; i++)
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Text(
                        '15h30',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.cloud),
                      Text('5˚'),
                      //

                      Icon(CupertinoIcons.wind_snow),
                      Text('20km/h'),
                      //

                      Icon(CupertinoIcons.umbrella_fill),
                      Text('10%'),
                      //
                      Icon(CupertinoIcons.drop_fill),
                      Text('1%'),
                    ],
                  ),
                )
            ]),
          ),
        ),
      ),
    );
  }
}
