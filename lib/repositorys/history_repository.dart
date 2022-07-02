import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary_en_to_en/models/history_model.dart';

class HistoryRepository {
  // 1
  final CollectionReference collection =
  FirebaseFirestore.instance.collection('HistoryModels');
  // 2
  // Stream<List<HistoryModel>> getStream() {
  //   return collection.get()
  //       .map((snapShot) => snapShot.docs
  //       .map((document) => HistoryModel.fromJson(document.data() as Map<String, dynamic>)
  //       .toList());
  // }
  // 3
  Future<DocumentReference> addHistoryModel(HistoryModel history) {
    return collection.add(history.toJson());
  }
}
