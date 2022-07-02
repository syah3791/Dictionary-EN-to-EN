import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary_en_to_en/models/history_model.dart';
import 'package:dictionary_en_to_en/repositorys/history_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingState with ChangeNotifier {
  BuildContext context;
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>(debugLabel: 'MainView');
  final HistoryRepository repository = HistoryRepository();
  bool _isLoading = false;
  List<HistoryModel> _historyList = [];
  SettingState(this.context){
  }


  bool get isLoading =>  _isLoading;
  get scaffoldState => _scaffoldState;
  get historyList =>  _historyList;

  void getInfoMainData() {
    _isLoading = true;

    notifyListeners();
  }

  // Stream<List<HistoryModel>> fetchOrders(String merchID) {
  //   return repository.getStream()
  //       .map((DocumentSnapshot document) {
  //     Map<String, dynamic> data =
  //     document.data()! as Map<String, dynamic>;
  //     return ListTile(
  //       title: Text(data['full_name']),
  //       subtitle: Text(data['company']),
  //     );
  //   })
  //       .toList()
  //       .cast();
  // }
}