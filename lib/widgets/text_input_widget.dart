import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    required this.labelText,
    this.controller,
    this.onChanged,
    this.validator,
  });
  final String? Function(String?)? validator;
  final String labelText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Theme.of(context).errorColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Theme.of(context).errorColor),
          ),
        ),
      ),
    );
  }
}
