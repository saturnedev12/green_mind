import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeListTile extends StatefulWidget {
  const HomeListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final bool isSelected;
  final void Function()? onTap;
  @override
  State<HomeListTile> createState() => _HomeListTileState();
}

FocusNode focusNode = FocusNode();

class _HomeListTileState extends State<HomeListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        right: BorderSide(
          width: 4,
          color: widget.isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.white,
        ),
      )),
      child: CupertinoListTile(
        backgroundColor: widget.isSelected
            ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
            : Colors.white,
        leading: Icon(
          widget.icon,
          color: widget.isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.grey[500],
        ),
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        //isThreeLine: true,

        onTap: widget.onTap,
      ),
    );
  }
}
