class HistoryModel {
  HistoryModel({this.id, this.word, this.favorite});

  String? id;
  String? word;
  bool? favorite;

  factory HistoryModel.fromJson(Map<String, dynamic> json, String refId) {
    return HistoryModel(
      id: refId,
      word: json['word'],
      favorite: json['favorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "word": word,
      "favorite": favorite,
    };
  }
}