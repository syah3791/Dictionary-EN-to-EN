import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dictionary_en_to_en/models/history_model.dart';

class HistoryRepository {
  // 1
  final CollectionReference collection =
  FirebaseFirestore.instance.collection('historys');
  // 2
  Stream<List<HistoryModel>> getStream() {
    return collection.snapshots()
        .map((snapShot) => snapShot.docs
        .map((document) => HistoryModel.fromJson(document.data()as Map<String, dynamic>, document.id)).toList());
  }
  // 3
  Future<DocumentReference> addHistoryModel(HistoryModel history) {
    return collection.add(history.toJson());
  }
  Future<void> updateHistoryModel(HistoryModel history) {
    return collection.doc(history.id).update({"favorite": history.favorite});
  }
}
