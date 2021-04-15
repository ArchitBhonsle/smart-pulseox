import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> _getRecords() async {
  http.Response response = await http.get(Uri.http('192.168.0.111:4000', ''));
  Map<String, dynamic> body = jsonDecode(response.body);

  return body;
}

class YourHistory extends StatefulWidget {
  @override
  _YourHistoryState createState() => _YourHistoryState();
}

class _YourHistoryState extends State<YourHistory> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _getRecords(), // a previously-obtained Future<String> or null
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        Widget child = Center(
          child: Text('NO DATA YET',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
        );
        if (snapshot.hasData) {
          var _entries = (snapshot.data!['data']);
          child = ListView.builder(
            itemCount: _entries.length,
            itemBuilder: (context, index) {
              final entry = _entries[index];

              return Card(
                child: ListTile(
                  title: Text(entry['name']!),
                  subtitle: Text(entry['phone']!),
                  trailing: Text(entry['oxygen']!.toString()),
                ),
              );
            },
          );
        }
        return child;
      },
    );
  }
}
