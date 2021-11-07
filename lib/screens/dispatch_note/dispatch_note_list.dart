import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/client.dart';
import 'package:nanti_flutter_web/models/dispatch_note.dart';
import 'package:nanti_flutter_web/screens/dispatch_note/edit_note_form.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
import 'package:nanti_flutter_web/services/client_service.dart';
import 'package:nanti_flutter_web/services/dispatch_note_service.dart';
import 'package:nanti_flutter_web/widgets/add_item_button.dart';

import '../../constants.dart';
import 'note_form.dart';

class DispatchNoteList extends StatefulWidget {
  const DispatchNoteList({Key? key}) : super(key: key);
  static String routeName = '/dispatch-note-list';

  @override
  _DispatchNoteListState createState() => _DispatchNoteListState();
}

class _DispatchNoteListState extends State<DispatchNoteList> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    List<Client> clientItems = [];
    ClientService.index().then((clients) {
      clients.forEach((client) {
        clientItems.add(client);
      });
    });
    return Responsive(
      appBarTitle: 'Dispatch Notes',
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: DispatchNoteService.index(),
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
                                content: NoteForm(
                                  clients: clientItems,
                                ),
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
                      child: buildTable(
                          snapShot.data as List<DispatchNote>?, clientItems),
                    ),
                  )
                ],
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  buildTable(List<DispatchNote>? data, List<Client> clientItems) {
    return data == null
        ? Center(
            child: Text('No data found'),
          )
        : DataTable(
            columns: ['Note', 'Client', 'Date', 'Actions']
                .map(buildTableColumn)
                .toList(),
            rows: data.map((e) {
              return buildTableRow(e, clientItems);
            }).toList(),
          );
  }

  DataColumn buildTableColumn(label) {
    return DataColumn(label: Text(label));
  }

  DataRow buildTableRow(DispatchNote note, List<Client> clientItems) {
    return DataRow(cells: [
      DataCell(Text(note.note)),
      DataCell(Text(note.client!.name)),
      DataCell(Text(note.noteDate)),
      DataCell(Row(
        children: [
          buildActionButton(
            icon: Icons.edit,
            onPressed: () {
              // TODO: refresh table after edit
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: NoteForm(clients: clientItems, note: note),
                    );
                  });
            },
          ),
          SizedBox(
            width: 20,
          ),
          buildActionButton(
            icon: Icons.delete,
            color: Colors.red,
            onPressed: () async {
              bool? deleted = await deleteDialog(note.id);
              String message = deleted == true ? 'Deleted' : 'Cancelled';
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(message),
              ));

              setState(() {});
            },
          ),
        ],
      )),
    ]);
  }

  Future<bool?> deleteDialog(id) async {
    return showDialog<bool?>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Item!'),
            content: Text(
              'Are you sure you want to delete this item?',
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    bool res = await DispatchNoteService.destroy(id);
                    Navigator.of(context).pop(res);
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No')),
            ],
          );
        });
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
