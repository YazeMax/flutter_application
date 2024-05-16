import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    this.obscureText = false,
    this.errorText = "Invalid input",
    this.borderColor = Colors.white,
    this.textColor = Colors.white,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.regex,
  });

  bool obscureText;
  final TextEditingController controller;
  final Color borderColor;
  final Color textColor;
  final RegExp regex;
  final String hintText;
  final String labelText;
  final String errorText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: widget.obscureText,
        controller: widget.controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.errorText;
          }
          if (!widget.regex.hasMatch(value)) {
            return widget.errorText;
          }
          return null;
        },
        decoration: InputDecoration(
          /* prefixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                  icon: Icon(
                    widget.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                )
              : null, */
          hintText: widget.hintText,
          label: Text(widget.labelText),
          hintStyle: TextStyle(color: widget.textColor),
          labelStyle: TextStyle(color: widget.textColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: widget.borderColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: widget.borderColor,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
