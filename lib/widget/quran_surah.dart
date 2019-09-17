import 'package:flutter/material.dart';

class QuranSurah extends StatelessWidget {
  final int id;
  final String name;
  final String arab;
  final String translate;
  final int countAyat;

  QuranSurah(this.id, this.name, this.arab, this.translate, this.countAyat);

  void _viewDetail(BuildContext context) {
    Navigator.of(context).pushNamed('/detail', arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        onTap: () => _viewDetail(context),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: 1, color: Colors.black),
            ),
          ),
          child: CircleAvatar(
            child: Text('$id'),
          ),
        ),
        title: Text(
          '$name ($arab)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.local_florist, color: Colors.pinkAccent,),
                Expanded(child: Text('Terjemahan: $translate')),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.local_florist, color: Colors.pinkAccent,),
                Text('Jumlah Ayat: $countAyat'),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.keyboard_arrow_right, size: 30,),
      ),
    );
  }
}
