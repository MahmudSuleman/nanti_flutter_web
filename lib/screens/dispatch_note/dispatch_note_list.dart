import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/dispatch_note.dart';
import 'package:nanti_flutter_web/models/select_item.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
import 'package:nanti_flutter_web/services/client_service.dart';
import 'package:nanti_flutter_web/services/dispatch_note_service.dart';
import 'package:nanti_flutter_web/widgets/add_item_button.dart';
import '../../constants.dart';

class DispatchNoteList extends StatefulWidget {
  const DispatchNoteList({Key? key}) : super(key: key);
  static String routeName = '/dispatch-note-list';

  @override
  _DispatchNoteListState createState() => _DispatchNoteListState();
}

class _DispatchNoteListState extends State<DispatchNoteList> {
  final _formKey = GlobalKey<FormState>();
  var _chosenValue;
  var chosenDate = '${DateTime.now()}';

  List<SelectItem> companyItems = [];

  @override
  void initState() {
    super.initState();

    ClientService.allClients().then((clients) {
      companyItems =
          clients.map((e) => SelectItem(id: e.id, name: e.name)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Responsive(
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: DispatchNoteService.allNote(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  kPageHeaderTitle('Dispatch Notes List', size),
                  Divider(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: AddItemButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: buildForm(),
                              );
                            }).then((value) => setState(() {}));
                      },
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 1000,
                    child: SingleChildScrollView(
                      child: buildTable(snapShot.data as List<DispatchNote>),
                    ),
                  )
                ],
              );
            }

            return CircularProgressIndicator();
          },
        ),
      ),
      appBarTitle: 'Dispatch Notes',
    );
  }

  buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(alignment: Alignment.bottomLeft, child: Text('Add New Note')),
          kDivider(),
          buildNoteDetailInput(),
          SizedBox(height: 20),
          buildClientDropDown(),
          SizedBox(height: 20),
          buildSubmitButton(),
          SizedBox(height: 20),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    buildShowDatePicker(context);
                  },
                  child: Text('Choose Date')),
              SizedBox(width: 20),
              Text(chosenDate),
            ],
          )
        ],
      ),
    );
  }

  buildShowDatePicker(context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now(),
    );
  }

  buildNoteDetailInput() {
    return TextFormField(
      decoration: kInputDecoration('Note Details'),
      maxLines: 3,
      validator: (value) {
        return value == null ? 'Note details is required' : '';
      },
    );
  }

  buildClientDropDown() {
    return DropdownButtonFormField(
      value: _chosenValue,
      decoration: kInputDecoration('Select Client'),
      items: companyItems
          .map((e) => DropdownMenuItem(value: '${e.id}', child: Text(e.name!)))
          .toList(),
      onChanged: (value) {
        _chosenValue = value;
      },
      validator: (value) {
        return value == null ? 'Client field requied' : '';
      },
    );
  }

  Align buildSubmitButton() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ElevatedButton(
        style: kElevatedButtonStyle(),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Submit',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  buildTable(List<DispatchNote> data) {
    return DataTable(
      columns:
          ['Note', 'Client', 'Date', 'Actions'].map(buildTableColumn).toList(),
      rows: data.map(buildTableRow).toList(),
    );
  }

  DataColumn buildTableColumn(label) {
    return DataColumn(label: Text(label));
  }

  DataRow buildTableRow(DispatchNote note) {
    return DataRow(cells: [
      DataCell(Text(note.note)),
      DataCell(Text(note.clientName!)),
      DataCell(Text(note.noteDate)),
      DataCell(Row(
        children: [
          buildActionButton(
            icon: Icons.edit,
            onPressed: () {},
          ),
          SizedBox(
            width: 20,
          ),
          buildActionButton(
            icon: Icons.delete,
            color: Colors.red,
            onPressed: () {},
          ),
        ],
      )),
    ]);
  }

  DataCell buildTableCell(DispatchNote note) {
    return DataCell(Text(note.note));
  }

  buildActionButton(
      {required IconData icon,
      required void Function()? onPressed,
      Color? color}) {
    return ElevatedButton(
      style: color != null
          ? kElevatedButtonStyle(color: color)
          : kElevatedButtonStyle(),
      child: Icon(icon),
      onPressed: onPressed,
    );
  }
}
