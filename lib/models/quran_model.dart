import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Quran {
  final int id;
  final String name;
  final String arab;
  final String translate;
  final int countAyat;

  Quran({
    @required this.id, 
    @required this.name, 
    @required this.arab, 
    @required this.translate, 
    @required this.countAyat
  });
}

class QuranData with ChangeNotifier {
  List<Quran> _data = [];
  int offset = 0;

  List<Quran> get items {
    return [..._data];
  }

  Future<void> getData() async {
    try {
      if (offset == _data.length) {
        final url = 'https://quran.kemenag.go.id/index.php/api/v1/surat/${offset}/10';
        final response = await http.get(url);
        final extractData = json.decode(response.body)['data'] as List;
        if (extractData == null || extractData.length == 0) {
          return;
        }
        
        final List<Quran> quranData = [];
        extractData.forEach((value) {
          quranData.add(Quran(
            id: value['id'],
            name: value['surat_name'],
            arab: value['surat_text'],
            translate: value['surat_terjemahan'],
            countAyat: value['count_ayat']
          ));
        });
        offset += quranData.length;
        _data.addAll(quranData);
        notifyListeners();
      }
    } catch(error) {
      throw error;
    }
  }

  Quran findById(int id) {
    return _data.firstWhere((item) => item.id == id);
  }
}