import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/company.dart';
import 'package:nanti_flutter_web/screens/add_edit_company.dart';
import 'package:nanti_flutter_web/services/company_service.dart';
import 'package:nanti_flutter_web/widgets/main_container.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Companies List'),
      ),
      body: MainContainer(
        child: FutureBuilder(
          future: CompanyService.allCompanies(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Text(
                    'Companies List',
                    style: kPageHeaderTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Divider(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AddEditCompany.routeName);
                        },
                        child: Text('Add Company'),
                      ),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      // scroll direction reduces the width
                      // that's why i am using media query
                      scrollDirection: MediaQuery.of(context).size.width > 600
                          ? Axis.vertical
                          : Axis.horizontal,
                      child: _buildTable(data: snapShot.data),
                    ),
                  )
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
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AddEditCompany.routeName,
                                  arguments: {
                                    'action': 'edit',
                                    'id': item.id,
                                    'name': item.name,
                                    'type': item.type,
                                    'contact': item.contact,
                                  });
                            },
                            child: Icon(Icons.edit),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
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

                                                if(res){
                                                   Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Data deleted!')));
                                                }else{
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
          );
  }
}
