import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenmind/configs/constants.dart';

class CustomLoadingButtom extends StatelessWidget {
  CustomLoadingButtom({
    Key? key,
    required this.text,
    this.onClick,
    this.clickable = true,
    this.color,
    this.textColor,
    required this.isLoading,
  }) : super(key: key);
  final String text;
  final void Function()? onClick;
  final Color? color;
  final Color? textColor;
  final bool isLoading;

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
                    ? HexColor.fromHex('#2172cb')
                    : color
                : Colors.grey[400],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: (clickable) ? onClick : null,
          child: (isLoading)
              ? CupertinoActivityIndicator(
                  radius: 16,
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
