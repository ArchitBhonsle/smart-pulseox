import 'package:flutter/material.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';

// Create a Form widget.
class NewRecord extends StatefulWidget {
  @override
  NewRecordState createState() {
    return NewRecordState();
  }
}

class NewRecordState extends State<NewRecord> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _name = '', _phone = '', _info = '', _gender = '';
    DateTime _dob = DateTime.now();
    bool _vaccinated = false;
    int _oxygen = 99, _pulse = 60;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: <Widget>[
                  Text(
                    '$_oxygen',
                    style:
                        TextStyle(fontSize: 70.0, fontWeight: FontWeight.bold),
                  ),
                  Text('Oxygen Level')
                ]),
                Column(children: <Widget>[
                  Text(
                    '$_pulse',
                    style:
                        TextStyle(fontSize: 70.0, fontWeight: FontWeight.bold),
                  ),
                  Text('Heart Rate')
                ]),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              onSaved: (newValue) {
                setState(() {
                  _name = newValue!;
                });
              },
              validator: (String? value) {
                return value!.isEmpty ? 'required field' : null;
              },
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                      ),
                      onSaved: (newValue) {
                        setState(() {
                          _phone = newValue!;
                        });
                      },
                      validator: (String? value) {
                        return value!.isEmpty ? 'required field' : null;
                      }),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputDatePickerFormField(
                    firstDate: DateTime.utc(1990, 1, 1),
                    lastDate: DateTime.utc(2020, 1, 1),
                    fieldLabelText: 'Date of Birth',
                    onDateSaved: (newValue) {
                      setState(() {
                        _dob = newValue;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CheckboxListTileFormField(
                    title: Text('Vaccinated'),
                    onSaved: (newValue) {
                      setState(() {
                        _vaccinated = newValue;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    onChanged: (value) {},
                    onSaved: (String? newValue) {
                      setState(() {
                        _gender = newValue!;
                      });
                    },
                    hint: Text('Gender'),
                    items: <String>['Male', 'Female', 'Other']
                        .map<DropdownMenuItem<String>>((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender[0],
                        child: Text(gender),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'More Info'),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              onSaved: (newValue) {
                setState(() {
                  _info = newValue!;
                });
              },
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  print(
                      '$_oxygen, $_pulse, $_name, $_phone, $_dob, $_vaccinated, $_gender, $_info');
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
