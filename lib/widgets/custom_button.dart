import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  CustomButtom({
    Key? key,
    required this.text,
    this.onClick,
    this.clickable = true,
    this.color,
    this.textColor,
  }) : super(key: key);
  final String text;
  final void Function()? onClick;
  final Color? color;
  final Color? textColor;

  bool clickable;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        //padding: EdgeInsets.only(left: 30, right: 30),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: (clickable)
                ? (color == null)
                    ? Theme.of(context).colorScheme.primary
                    : color
                : Colors.grey[400],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: (clickable) ? onClick : null,
          child: Text(
            text,
            style: TextStyle(
              color: (textColor == null) ? Colors.white : textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
