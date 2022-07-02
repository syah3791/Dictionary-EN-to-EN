import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary_en_to_en/models/history_model.dart';
import 'package:dictionary_en_to_en/repositorys/history_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirestoreState with ChangeNotifier {
  BuildContext context;
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>(debugLabel: 'MainView');
  final HistoryRepository repository = HistoryRepository();
  bool _isLoading = false;
  List<HistoryModel> _historyList = [];
  FirestoreState(this.context);


  bool get isLoading =>  _isLoading;
  get scaffoldState => _scaffoldState;
  List<HistoryModel> get historyList =>  _historyList;

  Stream<List<HistoryModel>> fetchHistorys() {
    return repository.getStream();
  }
  addHistory(String value) {
    return repository.addHistoryModel(HistoryModel(word: value, favorite: false));
  }

  updateHistoryFavorite(String id, bool value) {
    return repository.updateHistoryModel(HistoryModel(id: id, favorite: value));
  }
}