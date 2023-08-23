import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    this.labelText,
    this.sufixIcon,
    this.onTap,
    this.onSaved,
    this.onFieldSubmitted,
    this.controller,
    this.focusNode,
    this.minLines = 1,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.prefixText,
    this.prefixIcon,
    this.obscureText = false,
  }) : super(key: key);
  final String? labelText;
  final Widget? sufixIcon;
  final Widget? prefixIcon;
  final Function()? onTap;
  Function(String?)? onSaved;
  Function(String)? onFieldSubmitted;
  TextEditingController? controller = TextEditingController(text: '');
  final FocusNode? focusNode;
  final int minLines;
  final int? maxLines;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final bool obscureText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // FocusNode _textFieldFocus = FocusNode();
  Color _color = CupertinoColors.systemFill;
  Color _iconColor = CupertinoColors.systemGrey3;
  @override
  void initState() {
    // _textFieldFocus.addListener(() {
    //   if (_textFieldFocus.hasFocus) {
    //     setState(() {
    //       _color = HexColor.fromHex('#003a99').withOpacity(0.2);
    //       _iconColor = HexColor.fromHex('#003a99').withOpacity(0.4);
    //     });
    //   } else {
    //     setState(() {
    //       _color = Color.fromARGB(158, 234, 234, 234);
    //       _iconColor = Color.fromARGB(158, 202, 202, 202);
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(bottom: 10),
      //height: 55,

      child: TextFormField(
        style: TextStyle(
          fontSize: 20,
          // color: CupertinoColors.systemGrey4.darkColor,
        ),
        onChanged: ((value) {}),
        autovalidateMode: AutovalidateMode.onUserInteraction,

        validator: widget.validator,
        obscureText: widget.obscureText,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        onTap: widget.onTap,
        onSaved: widget.onSaved,
        onFieldSubmitted: widget.onFieldSubmitted,
        keyboardType: widget.textInputType,
        cursorColor: Theme.of(context).colorScheme.primary,
        cursorRadius: Radius.circular(5),
        //focusNode: widget.focusNode,
        inputFormatters: widget.inputFormatters,
        //cursorHeight: 10,
        //focusNode: _textFieldFocus,

        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0).copyWith(left: 10),
          //prefixIconColor: _iconColor,
          // suffixIconColor: _color,

          prefixText: widget.prefixText,
          //labelText: labelText!,
          prefixIcon: widget.prefixIcon,

          iconColor: Colors.black,
          hintText: widget.labelText,
          hintStyle: TextStyle(
            color: Colors.grey,
            //fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          filled: true,

          focusColor: Colors.white,
          suffixIcon: widget.sufixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(
          //     width: 1,
          //     color: HexColor.fromHex('#003a99'),
          //   ),
          // ),
        ),
      ),
    );
  }
}
