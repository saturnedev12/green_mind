import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenmind/feature/fields_page.dart/widgets/field_card.dart';

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
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            for (int i = 0; i < 10; i++) FieldCard(),
          ],
        ),
      ),
    );
  }
}
