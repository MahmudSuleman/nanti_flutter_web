import 'package:flutter/material.dart';

class DataTableWidget extends StatelessWidget {
  final List<DataRow> data;
  final List<String> header;

  const DataTableWidget({Key? key, required this.data, required this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: header.map((e) => DataColumn(label: Text(e))).toList(),
      rows: data,
    );
  }
}
