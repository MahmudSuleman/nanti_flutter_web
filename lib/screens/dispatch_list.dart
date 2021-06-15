import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/dispatch.dart';
import 'package:nanti_flutter_web/services/dispatch_service.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';

class DispatchList extends StatefulWidget {
  static const routeName = '/dispatch-list';
  @override
  _DispatchListState createState() => _DispatchListState();
}

class _DispatchListState extends State<DispatchList> {
  // ignore: unused_field

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dispatched Devices'),
          bottom: TabBar(
            tabs: [
              Text(
                'Available Devices',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                'Dispatched Devices',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: DispatchService.allDispatches(),
            builder: (_, snapShot) {
              if (snapShot.connectionState == ConnectionState.done) {
                if (snapShot.data != null) {
                  List<Dispatch> data = snapShot.data as List<Dispatch>;
                  List<Dispatch> available = [];
                  List<Dispatch> dispatched = [];

                  List<String> _availableTableHeader = [
                    'Device Name',
                    'Company Name',
                    'Action',
                  ];

                  List<String> _dispachedTableHeader = [
                    'Device Name',
                    'Company Name',
                    'Action',
                  ];

                  for (Dispatch item in data) {
                    if (item.isAvailable == '1') {
                      print('available data found');
                      available.add(Dispatch(
                        companyName: item.companyName,
                        deviceName: item.deviceName,
                        isAvailable: item.isAvailable,
                        id: item.id,
                      ));
                    } else {
                      print('dispatched data found');

                      dispatched.add(Dispatch(
                        companyName: item.companyName,
                        deviceName: item.deviceName,
                        isAvailable: item.isAvailable,
                        id: item.id,
                      ));
                    }
                  }

                  return MainContainer(
                    child: TabBarView(
                      children: [
                        _buildTable(
                            header: _availableTableHeader, data: available),
                        _buildTable2(
                            header: _dispachedTableHeader, data: dispatched),
                      ],
                    ),
                  );
                } else
                  return Text('no data');
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  _buildTable({List<String>? header, data}) {
    return data == null
        ? Center(
            child: Text('No data found'),
          )
        : SingleChildScrollView(
            child: DataTable(
                columns:
                    header!.map((e) => DataColumn(label: Text(e))).toList(),
                rows: [
                  for (Dispatch item in data)
                    DataRow(cells: [
                      DataCell(Text(item.companyName)),
                      DataCell(Text(item.deviceName)),
                      DataCell(
                        Text('data'),
                      ),
                    ])
                ]),
          );
  }

  _buildTable2({List<String>? header, data}) {
    return data == null
        ? Center(
            child: Text('No data found'),
          )
        : SingleChildScrollView(
            child: DataTable(
                columns:
                    header!.map((e) => DataColumn(label: Text(e))).toList(),
                rows: [
                  for (Dispatch item in data)
                    DataRow(cells: [
                      DataCell(Text(item.companyName)),
                      DataCell(Text(item.deviceName)),
                      DataCell(Text('')),
                    ])
                ]),
          );
  }
}
