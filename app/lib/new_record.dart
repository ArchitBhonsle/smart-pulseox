// import 'dart:async';
// import 'dart:convert';

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:http/http.dart' as http;

Future<http.Response> createRecord(Map<String, dynamic> data) {
  return http.post(
    Uri.http('192.168.0.111:4000', ''),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{'data': data}),
  );
}

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
  void initState() async {
    super.initState();

    BluetoothDevice connectedDevice =
        (await FlutterBluetoothSerial.instance.getBondedDevices())
            .firstWhere((element) => element.isConnected);
    print(connectedDevice.name);
    try {
      BluetoothConnection connection =
          await BluetoothConnection.toAddress(connectedDevice.address);
      print('Connected to the device');

      connection.input.listen((Uint8List data) {
        print('Data incoming: ${ascii.decode(data)}');
        connection.output.add(data); // Sending data

        if (ascii.decode(data).contains('!')) {
          connection.finish(); // Closing connection
          print('Disconnecting by local host');
        }
      }).onDone(() {
        print('Disconnected by remote request');
      });
    } catch (exception) {
      print('Cannot connect, exception occured');
    }
  }

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
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  Map<String, double> loc = await getLocation();

                  Map<String, dynamic> data = {
                    'name': _name,
                    'phone': _phone,
                    'dob': _dob.toIso8601String(),
                    'gender': _gender,
                    'vaccinated': _vaccinated,
                    'info': _info,
                    'oxygen': _oxygen,
                    'pulse': _pulse,
                    'location': <String, dynamic>{
                      'type': 'Point',
                      'coordinates': <double>[
                        loc['longitude']!,
                        loc['latitude']!
                      ]
                    }
                  };

                  await createRecord(data);
                  print(data);
                  var devices =
                      await FlutterBluetoothSerial.instance.getBondedDevices();
                  devices.forEach((element) {
                    print(
                        '${element.name} ${element.address} ${element.isConnected}');
                  });

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Data Sent',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.greenAccent,
                  ));
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

Future<Map<String, double>> getLocation() async {
  Map<String, double> locationMap = {};
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  Position pos = await Geolocator.getCurrentPosition();
  locationMap = {
    'latitude': pos.latitude,
    'longitude': pos.longitude,
  };

  return locationMap;
}
