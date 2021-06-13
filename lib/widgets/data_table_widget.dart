// import 'package:flutter/material.dart';

// class DataTableWidget extends StatelessWidget {
//   final List<dynamic> data;
//   final List<String> header;

//   const DataTableWidget({Key? key, required this.data, required this.header}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return data == null
//         ? Center(
//             child: Text('No data found'),
//           )
//         : SingleChildScrollView(
//             child: DataTable(
//                 columns: header
//                     .map((e) => DataColumn(label: Text(e)))
//                     .toList(),
//                 rows: [
//                   for (Device item in data)
//                     DataRow(cells: [
//                       DataCell(Text(item.serialNumber)),
//                       DataCell(Text(item.name)),
//                       DataCell(Text(item.manufactuer)),
//                       DataCell(Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.pushNamed(context, AddEditDevice.routeName,
//                                   arguments: {
//                                     'action': 'edit',
//                                     'id': item.id,
//                                     'name': item.name,
//                                     'manufacturer': item.manufactuer,
//                                     'serialNumber': item.serialNumber
//                                   });
//                             },
//                             child: Icon(Icons.edit),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                         content: Text(
//                                             'Are you sure you want to delete this item?'),
//                                         actions: [
//                                           MaterialButton(
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                               ScaffoldMessenger.of(context)
//                                                   .showSnackBar(SnackBar(
//                                                       content: Text(
//                                                           'Data deleted!')));
//                                             },
//                                             // color: Colors.red,
//                                             child: Text('Yes'),
//                                           ),
//                                           MaterialButton(
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                             // color: Colors.red,
//                                             child: Text('No'),
//                                           )
//                                         ],
//                                       ));
//                             },
//                             child: Icon(Icons.delete),
//                           ),
//                         ],
//                       )),
//                     ])
//                 ]),
//           );
//   }
//   }
// }
