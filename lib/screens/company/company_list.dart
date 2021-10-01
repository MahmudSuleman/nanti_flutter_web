import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/company.dart';
import 'package:nanti_flutter_web/screens/company/add_company.dart';
import 'package:nanti_flutter_web/screens/company/edit_company.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/services/company_service.dart';
import 'package:nanti_flutter_web/widgets/add_item_button.dart';

class CompanyList extends StatefulWidget {
  static const routeName = '/company-list';

  @override
  _CompanyListState createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList> {
  List<String> _tableHeader = [
    'Name',
    'Type',
    'Contact',
    'Actions',
  ];
  @override
  Widget build(BuildContext context) {
    AuthService.autoLogout(context);
    final size = MediaQuery.of(context).size.width;

    return Responsive(
      appBarTitle: 'Companies List',
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: CompanyService.allCompanies(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  kPageHeaderTitle('Companies List', size),
                  Divider(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: AddItemButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: AddCompany(),
                              );
                            }).then((value) => setState(() {}));
                      },
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  _buildTable(data: snapShot.data)
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  _buildTable({data}) {
    return data == null
        ? Center(
            child: Text('No data found'),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: 1000,
              child: DataTable(
                  columns: _tableHeader
                      .map((e) => DataColumn(label: Text(e)))
                      .toList(),
                  rows: [
                    for (Company item in data)
                      DataRow(cells: [
                        DataCell(Text(item.name)),
                        DataCell(Text(item.type)),
                        DataCell(Text(item.contact)),
                        DataCell(Row(
                          children: [
                            ElevatedButton(
                              style: kElevatedButtonStyle(),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: EditCompany(
                                          new Company(
                                            id: item.id,
                                            name: item.name,
                                            type: item.type,
                                            contact: item.contact,
                                          ),
                                        ),
                                      );
                                    }).then((value) => setState(() {}));
                              },
                              child: Icon(Icons.edit),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: kElevatedButtonStyle(color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text(
                                        'Are you sure you want to delete this item?'),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () async {
                                          var res =
                                              await CompanyService.destroy(
                                                  item.id);

                                          if (res) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content:
                                                        Text('Data deleted!')));
                                          } else {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Failed to delete device data!')));
                                          }
                                        },
                                        // color: Colors.red,
                                        child: Text('Yes'),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        // color: Colors.red,
                                        child: Text('No'),
                                      )
                                    ],
                                  ),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              child: Icon(Icons.delete),
                            ),
                          ],
                        )),
                      ])
                  ]),
            ),
          );
  }
}
