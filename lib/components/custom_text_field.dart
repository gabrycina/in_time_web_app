import 'package:flutter_web/material.dart';
import 'package:in_time/constants.dart';

//Class used to generate text fields

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.customIcon,
      this.placeholderText,
      this.onChangedFunction,
      this.controller,
      this.obscure,
      this.maxLength});

  final IconData customIcon;
  final String placeholderText;
  final Function onChangedFunction;
  final TextEditingController controller;
  final bool obscure;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      obscureText: obscure,
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: onChangedFunction,
      style: TextStyle(
        fontSize: 30,
        color: Colors.white
      ),
      maxLength: maxLength,
      decoration: kTextFieldStyle.copyWith(
        prefixIcon: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            customIcon,
            color: Colors.orange,
          ),
        ),
        hintText: placeholderText,
        hintStyle: TextStyle(
          fontFamily: "HelveticaLight",
          color: Colors.grey,
        ),
      ),
    );
  }
}
