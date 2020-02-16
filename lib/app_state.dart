import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AppState with ChangeNotifier {
  AppState();

  String _dataUrl = "https://jsonplaceholder.typicode.com/users";
  String _jsonResonse = "";
  bool _isFetching = false;
  List _data;

  bool get isFetching => _isFetching;

  Future<void> fetchData() async {
    _isFetching = true;
    notifyListeners();

    var response = await http.get(_dataUrl);
    if (response.statusCode == 200) {
      _jsonResonse = response.body;
      if (_jsonResonse.isNotEmpty) {
        _data = jsonDecode(_jsonResonse);
        for (var item in _data) {
          item['selected'] = false;
        }

        //return json['data'];
      }
    }

    _isFetching = false;
    notifyListeners();
  }

  List<dynamic> getResponseJson() {
    return _data;
  }

  void deleteSelected() {
    var toRemove = [];

    _data.forEach((e) {
      if (e["selected"]) toRemove.add(e);
    });

    _data.removeWhere((e) => toRemove.contains(e));
    notifyListeners();
  }

  void unselectAll() {
    for (var item in _data) {
      item['selected'] = false;
    }

    notifyListeners();
  }
 bool toggleAppbarButtons(){
    if(_data!=null)
   for (var item in _data) {
     if (item['selected']) {
       return true;

     }
   }
   return false;

  }
}
