import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenmind/feature/map/simple_map.dart';

class FieldCard extends StatelessWidget {
  const FieldCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 330,
      margin: EdgeInsets.all(20),
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
                width: 380,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                child: SimpleMap(),
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
                    onPressed: () {},
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
                    title: Text('Champ de maïs'),
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
                        Text('20 ha'),
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
