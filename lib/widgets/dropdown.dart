import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/select_item.dart';

class DropDownButtonWidget extends StatefulWidget {
  final List<SelectItem>? options;
  final Function validator;
  final String hintText;

  DropDownButtonWidget({
    required this.options,
    required this.validator,
    required this.hintText,
  });

  @override
  _DropDownButtonWidgetState createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  String? _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: DropdownButtonFormField<String>(
        value: _chosenValue,
        //elevation: 5,
        style: TextStyle(color: Colors.black),
        items: widget.options!
            .map(
              (item) => DropdownMenuItem<String>(
                value: '${item.id}',
                child: Text('${item.name}'),
              ),
            )
            .toList(),

        hint: Text(
          widget.hintText,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onChanged: (String? value) {
          setState(() {
            _chosenValue = value!;
          });
        },
        validator: (value) => widget.validator(value),
      ),
    );
  }
}
