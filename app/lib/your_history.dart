import 'package:flutter/material.dart';

class YourHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _entries = [
      {
        'name': 'Archit Bhonsle',
        'phone': '7498445599',
        'oxygen': 98,
      },
      {
        'name': 'Sachin Bhonsle',
        'phone': '7498667799',
        'oxygen': 95,
      },
      {
        'name': 'Vaishali Bhonsle',
        'phone': '7498556699',
        'oxygen': 98,
      },
    ];

    return ListView.builder(
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
}
