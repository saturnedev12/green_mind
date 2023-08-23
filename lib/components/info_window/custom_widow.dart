import 'package:flutter/material.dart';

import '../../data/models/AddressClass.dart';
import '../../data/models/citycab_info_window.dart';

class CustomWindow extends StatelessWidget {
  const CustomWindow({Key? key, required this.info}) : super(key: key);
  final CityCabInfoWindow info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, spreadRadius: 2, blurRadius: 5),
                ],
              ),
              width: double.infinity,
              height: double.infinity,
              child: Container(
                child: info.type == InfoWindowType.position
                    ? Row(
                        children: [
                          if (info.type == InfoWindowType.position)
                            Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              color: Color.fromRGBO(8, 161, 120, 1),
                              height: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('10',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(color: Colors.white)),
                                  Text('min',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(color: Colors.white)),
                                ],
                              ),
                            ),
                          SizedBox(width: 10),
                          Expanded(
                              child: Text(
                            'Votre position',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.black),
                          )),
                          Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.black),
                          const SizedBox(width: 4),
                        ],
                      )
                    : Row(
                        children: [
                          if (info.type == InfoWindowType.position)
                            Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              color: Color.fromRGBO(8, 161, 120, 1),
                              height: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('10',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(color: Colors.white)),
                                  Text('min',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(color: Colors.white)),
                                ],
                              ),
                            ),
                          SizedBox(width: 10),
                          Expanded(
                              child: Text(
                            User().destination,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.black),
                          )),
                          Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.black),
                          const SizedBox(width: 4),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
