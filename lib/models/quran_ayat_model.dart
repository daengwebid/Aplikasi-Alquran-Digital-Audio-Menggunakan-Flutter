import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QuranAyatModel {
  final int ayatId;
  final int ayatNumber;
  final int surahId;
  final int juzId;
  final String ayatArab;
  final String ayatText;

  QuranAyatModel({
    @required this.ayatId,
    @required this.ayatNumber,
    @required this.surahId,
    @required this.juzId,
    @required this.ayatArab,
    @required this.ayatText,
  });
}

class QuranAyat with ChangeNotifier {
  List<QuranAyatModel> _data = [];
  List _mp3 = [
    'http://ia802609.us.archive.org/13/items/quraninindonesia/001AlFaatihah.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/002AlBaqarah.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/003AliImran.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/004AnNisaa.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/005AlMaaidah.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/006AlAnaam.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/007AlAaraaf.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/008AlAnfaal.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/009AtTaubah.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/010Yunus.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/011Huud.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/012Yusuf.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/013ArRaad.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/014Ibrahim.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/015AlHijr.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/016AnNahl.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/017AlIsraa.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/018AlKahfi.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/019Maryam.mp3',
    'http://ia802609.us.archive.org/13/items/quraninindonesia/020Thaahaa2.mp3'
  ];

  List<QuranAyatModel> get items {
    return [..._data];
  }

  String findMp3Url(id) {
    return _mp3[id - 1];
  }

  Future<void> getDetail(int id, int navigationBarIndex, int offset, int total) async {
    if ((navigationBarIndex == 2 && total == offset) || (navigationBarIndex == 0 && total > offset)) {
      final url = 'https://quran.kemenag.go.id/index.php/api/v1/ayatweb/$id/0/$offset/10';
      final response = await http.get(url);
      final extractData = json.decode(response.body)['data'] as List;

      if (extractData == null) {
        return;
      }

      final List<QuranAyatModel> ayatData = [];
      extractData.forEach((value) {
        ayatData.add(QuranAyatModel(
          ayatId: value['aya_id'],
          ayatNumber: value['aya_number'],
          surahId: value['sura_id'], 
          juzId: value['juz_id'],
          ayatArab: value['aya_text'],
          ayatText: value['translation_aya_text']
        ));
      });

      _data = ayatData;
      notifyListeners();
    }
  }
}