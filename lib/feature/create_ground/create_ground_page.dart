import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateGroundPage extends StatefulWidget {
  const CreateGroundPage({super.key});

  @override
  State<CreateGroundPage> createState() => _CreateGroundPageState();
}

class _CreateGroundPageState extends State<CreateGroundPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
           
          
            Center(
              child: GestureDetector(
                onTap: () => context.go('/map'),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
