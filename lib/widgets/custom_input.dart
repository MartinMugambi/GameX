import 'package:flutter/material.dart';
import 'package:game_store_app/constants.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChnaged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;
  CustomInput({
    this.hintText,
    this.onChnaged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.isPasswordField,
  });
  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        focusNode: focusNode,
        onChanged: onChnaged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        obscureText: _isPasswordField,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? 'Hint Text',
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 18.0,
            )),
        style: Constants.regularDarkText,
      ),
    );
  }
}
