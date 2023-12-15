import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenmind/feature/fields_page.dart/widgets/field_card.dart';
import 'package:greenmind/feature/fields_page.dart/widgets/load_field_card.dart';
import 'package:greenmind/services/firestore_services.dart';

class FieldPage extends StatefulWidget {
  const FieldPage({super.key});

  @override
  State<FieldPage> createState() => _FieldPageState();
}

class _FieldPageState extends State<FieldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemFill,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Champs'),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        actions: [
          SizedBox(width: 300, child: CupertinoSearchTextField()),
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.filter_list_rounded,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: FireStoreServices.getArticlesByUserId(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.count(
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: snapshot.data!
                  .map((e) => FieldCard(
                        field: e,
                      ))
                  .toList(),
            );

            SingleChildScrollView(
              child: Wrap(
                children: snapshot.data!
                    .map((e) => FieldCard(
                          field: e,
                        ))
                    .toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            );
          }
          return GridView.count(
            primary: false,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              for (int i = 0; i < 10; i++) LoadFieldCard(),
            ],
          );
        },
      ),
    );
  }
}
