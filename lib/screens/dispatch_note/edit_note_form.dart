import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nanti_flutter_web/models/dispatch_note.dart';
import 'package:nanti_flutter_web/models/select_item.dart';
import 'package:nanti_flutter_web/services/client_service.dart';
import 'package:nanti_flutter_web/services/dispatch_note_service.dart';

import '../../constants.dart';

class EditNoteForm extends StatefulWidget {
  const EditNoteForm({Key? key, required this.note}) : super(key: key);
  final DispatchNote note;

  @override
  _EditNoteFormState createState() => _EditNoteFormState();
}

class _EditNoteFormState extends State<EditNoteForm> {
  var _formKey = GlobalKey<FormState>();
  var chosenDate;
  var _chosenValue;
  var noteDetails;
  var clientId;

  List<SelectItem> companyItems = [];

  @override
  Widget build(BuildContext context) {
    chosenDate = widget.note.noteDate;
    noteDetails = widget.note.note;
    clientId = widget.note.clientId;
    ClientService.allClients().then((clients) {
      companyItems = clients.map((e) {
        return SelectItem(id: e.id.toString(), name: e.name);
      }).toList();
      if (this.mounted) setState(() {});
    });
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.bottomLeft,
              child: Text('Edit Note Details')),
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
    );
  }

  buildShowDatePicker(context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.parse('2000-01-01'),
      lastDate: DateTime.now(),
    ).then((value) => setState(() {
          chosenDate = '${DateFormat.yMd().format(value!)}';
        }));
  }

  buildNoteDetailInput() {
    return TextFormField(
      initialValue: widget.note.note,
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
      value: _chosenValue ?? widget.note.clientId,
      decoration: kInputDecoration('Select Client'),
      items: companyItems
          .map((e) =>
              DropdownMenuItem(value: '${e.id}', child: Text('${e.name}')))
          .toList(),
      onChanged: (value) {
        print(value);
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
        style: kElevatedButtonStyle(),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            DispatchNoteService.editNote(DispatchNote(
              id: widget.note.id,
              clientId: clientId,
              note: noteDetails,
              noteDate: chosenDate,
            )).then((value) {
              setState(() {});
              if (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Data saved successfully'),
                  ),
                );
                Navigator.of(context).pop(true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to save'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            });
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
}
