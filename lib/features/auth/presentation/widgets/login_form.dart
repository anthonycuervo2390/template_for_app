import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginField extends StatefulWidget {
  final hintText;
  var isPassword;
  var isSecure;
  Key key;
  TextInputAction textInputAction;
  FocusNode focusNode;
  VoidCallback onEditingComplete;
  final Function validator;
  final Function onPressed;
  final Function onChanged;
  final TextEditingController controller;
  LoginField(
      {this.hintText,
      this.key,
      this.focusNode,
      this.onChanged,
      this.onEditingComplete,
      this.textInputAction,
      this.validator,
      this.controller,
      this.onPressed,
      this.isPassword = true,
      this.isSecure = false});

  @override
  _LoginFieldState createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isSecure) {
      return TextFormField(
        onChanged: widget.onChanged,
        key: widget.key,
        textInputAction: widget.textInputAction,
        onEditingComplete: widget.onEditingComplete,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.isPassword,
        style: TextStyle(fontSize: 16, color: Colors.white),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey.shade700),
          filled: true,
          fillColor: Color(0xff161d27).withOpacity(0.9),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      );
    } else {
      return TextFormField(
        key: widget.key,
        textInputAction: widget.textInputAction,
        onEditingComplete: widget.onEditingComplete,
        focusNode: widget.focusNode,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.isPassword,
        style: TextStyle(fontSize: 16, color: Colors.white),
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                widget.isPassword = !widget.isPassword;
              });
            },
            child: Icon(
              widget.isPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.red,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey.shade700),
          filled: true,
          fillColor: Color(0xff161d27).withOpacity(0.9),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      );
    }
  }
}
