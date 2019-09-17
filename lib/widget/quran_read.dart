import 'package:flutter/material.dart';

class QuranRead extends StatelessWidget {
  final int ayatNumber;
  final String ayatArab;
  final String ayatText;

  QuranRead(this.ayatNumber, this.ayatArab, this.ayatText);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(child: Text('$ayatNumber'),),
        title: Text(
          '$ayatArab',
          textAlign: TextAlign.right,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text('$ayatText'),
      ),
    );
  }
}
