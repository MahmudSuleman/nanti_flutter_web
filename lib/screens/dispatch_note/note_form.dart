import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nanti_flutter_web/models/client.dart';
import 'package:nanti_flutter_web/models/dispatch_note.dart';
import 'package:nanti_flutter_web/services/dispatch_note_service.dart';

import '../../constants.dart';

class NoteForm extends StatefulWidget {
  const NoteForm({Key? key, required this.clients, this.note})
      : super(key: key);
  final List<Client> clients;
  final DispatchNote? note;

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  var _formKey = GlobalKey<FormState>();
  var chosenDate = DateFormat.yMMMd().format(DateTime.now());
  var _chosenValue;
  var noteDetails;
  var clientId;

  @override
  Widget build(BuildContext context) {
    if (widget.note != null) {
      setState(() {
        chosenDate = widget.note!.noteDate;
        clientId = widget.note!.clientId;
      });
    }
    return SingleChildScrollView(
      child: Form(
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
            ),
            SizedBox(height: 20),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  buildShowDatePicker(context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.parse('2000-01-01'),
      lastDate: DateTime.now(),
    ).then((value) => setState(() {
          chosenDate = '${DateFormat.yMMMd().format(value!)}';
        }));
  }

  buildNoteDetailInput() {
    return TextFormField(
      initialValue: widget.note?.note,
      decoration: kInputDecoration('Note Details'),
      maxLines: 3,
      validator: (value) {
        return value == null || value.isEmpty
            ? 'Note details is required'
            : null;
      },
      onSaved: (value) {
        noteDetails = value;
      },
    );
  }

  buildClientDropDown() {
    return DropdownButtonFormField(
      value: widget.note != null ? widget.note!.clientId : _chosenValue,
      decoration: kInputDecoration('Select Client'),
      items: widget.clients
          .map((e) => DropdownMenuItem(value: e.id, child: Text(e.name)))
          .toList(),
      onChanged: (value) {
        setState(() {
          clientId = value;
          _chosenValue = value;
        });
      },
      validator: (value) {
        return value == null ? 'Client field is required' : null;
      },
    );
  }

  buildSubmitButton() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Submit',
              style: TextStyle(fontSize: 18),
            ),
          ),
          style: kElevatedButtonStyle(),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              var response = widget.note == null
                  ? await DispatchNoteService.store(
                      DispatchNote(
                        clientId: clientId,
                        note: noteDetails,
                        noteDate: chosenDate,
                      ),
                    )
                  : await DispatchNoteService.update(
                      DispatchNote(
                        id: widget.note!.id,
                        clientId: clientId,
                        note: noteDetails,
                        noteDate: chosenDate,
                      ),
                    );

              String successMessage = widget.note == null
                  ? 'Note added successfully'
                  : 'Note updated successfully';
              if (response) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(successMessage)));
                Navigator.of(context).pop(true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Something went wrong'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          }),
    );
  }
}
