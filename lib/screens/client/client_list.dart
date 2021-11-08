import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/constants.dart';
import 'package:nanti_flutter_web/models/client.dart';
import 'package:nanti_flutter_web/models/client_type.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
import 'package:nanti_flutter_web/services/auth_service.dart';
import 'package:nanti_flutter_web/services/client_service.dart';
import 'package:nanti_flutter_web/services/client_type_service.dart';
import 'package:nanti_flutter_web/widgets/add_item_button.dart';

class ClientList extends StatefulWidget {
  static const routeName = '/client-list';

  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  List<String> _tableHeader = [
    'Name',
    'Type',
    'Contact',
    'Actions',
  ];

  final _formKey = GlobalKey<FormState>();
  var selectedClientType;
  Client _client = Client(name: '', contact: '', clientTypeId: 0);
  List<ClientType> types = [];

  @override
  void initState() {
    super.initState();
    ClientTypeService.allClientTypes().then((value) {
      value.forEach((element) {
        types.add(element);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService.autoLogout(context);
    final size = MediaQuery.of(context).size.width;
    return Responsive(
      appBarTitle: 'Clients List',
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: ClientService.index(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  kPageHeaderTitle('Clients List', size),
                  Divider(),
                  buildAddButton(),
                  Divider(),
                  SizedBox(height: 20),
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

  buildClientForm({Client? client}) => Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(client != null ? 'Edit Client' : 'Add Client'),
          kDivider(),
          TextFormField(
            initialValue: client != null ? client.name : '',
            decoration: kInputDecoration('Name'),
            validator: (value) {
              return value == null || value.isEmpty ? 'Name is required' : null;
            },
            onSaved: (value) {
              _client.name = value!;
            },
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButtonFormField<int>(
            value: client != null ? client.clientTypeId : selectedClientType,
            decoration: kInputDecoration('Client Type'),
            onChanged: (value) {
              setState(() {
                selectedClientType = value;
              });
            },
            onSaved: (value) {
              _client.clientTypeId = value!;
            },
            items: types
                .map(
                  (clientType) => DropdownMenuItem<int>(
                    value: clientType.id,
                    child: Text(clientType.name),
                  ),
                )
                .toList(),
            validator: (value) {
              return value == null ? 'Client Type is required' : null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue: client != null ? client.contact : '',
            decoration: kInputDecoration('Contact'),
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'Contact is required'
                  : null;
            },
            onSaved: (value) {
              _client.contact = value!;
            },
          ),
          kDivider(),
          ElevatedButton(
            style: kElevatedButtonStyle(),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _client.id = client != null ? client.id : null;
                var response = client != null
                    ? await ClientService.update(_client)
                    : await ClientService.store(_client);

                String successMessage = client != null
                    ? 'Client updated successfully'
                    : 'Client added successfully';
                if (response.statusCode == 200 || response.statusCode == 201) {
                  kSuccessSnackBar(
                    context,
                    successMessage,
                  );
                  Navigator.pop(context, true);
                } else {
                  kFailureSnackBar(
                    context,
                    'Something went wrong',
                  );
                }
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ));

  Align buildAddButton() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: AddItemButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: buildClientForm(),
                );
              }).then((value) => setState(() {}));
        },
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
                    for (Client item in data)
                      DataRow(cells: [
                        DataCell(Text('${item.name}')),
                        DataCell(Text('${item.clientType!.name}')),
                        DataCell(Text('${item.contact}')),
                        DataCell(buildAddEditTableRow(item)),
                      ])
                  ]),
            ),
          );
  }

  buildAddEditTableRow(Client item) {
    return Row(
      children: [
        buildEditButton(item),
        SizedBox(width: 10),
        buildDeleteButton(item),
      ],
    );
  }

  buildDeleteButton(Client item) {
    return ElevatedButton(
      style: kElevatedButtonStyle(color: Colors.red),
      child: Icon(Icons.delete),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text('Are you sure you want to delete this item?'),
            actions: [
              MaterialButton(
                child: Text('Yes'),
                onPressed: () async {
                  var res = await ClientService.destroy(item.id);
                  if (res) {
                    Navigator.pop(context);
                    kSuccessSnackBar(context, 'Client deleted successfully');
                  } else {
                    Navigator.pop(context);
                    kFailureSnackBar(context, 'Something went wrong');
                  }
                },
              ),
              MaterialButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ).then((value) {
          setState(() {});
        });
      },
    );
  }

  buildEditButton(Client item) {
    return ElevatedButton(
      style: kElevatedButtonStyle(),
      child: Icon(Icons.edit),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: buildClientForm(
                  client: Client(
                    id: item.id,
                    name: item.name,
                    clientTypeId: item.clientTypeId,
                    contact: item.contact,
                  ),
                ),
              );
            }).then((value) => setState(() {}));
      },
    );
  }
}
