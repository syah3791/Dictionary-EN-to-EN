import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary_en_to_en/models/history_model.dart';
import 'package:dictionary_en_to_en/models/word_model.dart';
import 'package:dictionary_en_to_en/repositorys/history_repository.dart';
import 'package:dictionary_en_to_en/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DictionaryState with ChangeNotifier {
  BuildContext context;
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>(debugLabel: 'MainView');
  final HistoryRepository repository = HistoryRepository();
  bool _isLoading = false;
  WordModel _wordData = new WordModel();
  DictionaryState(this.context){
  }


  bool get isLoading =>  _isLoading;
  get scaffoldState => _scaffoldState;
  WordModel get wordData =>  _wordData;

  getWord(String word){
    _isLoading = true;
    notifyListeners();
    ApiClient().get(
      url: '${APIUrl.en}',
      params: word,
      callback: (status, message, res) async {
        _isLoading = false;
        print(res);
        if (message == true) {
          if(res.length > 0) {
            _wordData = WordModel.fromJson(jsonDecode(res)[0] as Map<String, dynamic>);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('$res'),
          ));
        }
        notifyListeners();
        return;
      },
    );
  }
}