import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/manufacturer.dart';
import 'package:nanti_flutter_web/providers/manufacturer_provider.dart';
import 'package:provider/provider.dart';

class ManufacturerDropDown extends StatefulWidget {
  const ManufacturerDropDown({Key? key}) : super(key: key);

  @override
  ManufacturerDropDownState createState() => ManufacturerDropDownState();
}

class ManufacturerDropDownState extends State<ManufacturerDropDown> {
  String? selectedValue;

  String? manufacturerId;
  late List<DropdownMenuItem<String>> items;
  @override
  Widget build(BuildContext context) {
    items = Provider.of<ManufacturerProvider>(context)
        .allManufacturers
        .map((Manufacturer m) {
      return DropdownMenuItem<String>(
        value: '${m.id}',
        child: Text(m.name),
      );
    }).toList();
    return Text('jjj');
  }
}
