import 'package:flutter/material.dart';
import 'package:nanti_flutter_web/models/dispatch_note.dart';
import 'package:nanti_flutter_web/screens/dispatch_note/add_note_form.dart';
import 'package:nanti_flutter_web/screens/responsive/responsive.dart';
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
                                content: AddNoteForm(),
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

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      appBarTitle: 'Dispatch Notes',
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
