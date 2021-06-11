import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    required this.labelText,
    this.controller,
    this.onChanged,
    this.validator,
    this.initValue,
  });
  final String? initValue;
  final String? Function(String?)? validator;
  final String labelText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        initialValue: initValue,
        validator: validator,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(labelText: labelText),
      ),
    );
  }
}
