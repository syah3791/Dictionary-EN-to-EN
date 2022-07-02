class WordModel {
  WordModel({this.id, this.word, this.phonetic, this.phonetics, this.origin,
    this.meanings
  });

  String? id;
  String? word;
  String? phonetic;
  List<PhoneticsModel>? phonetics;
  String? origin;
  List<MeaningsModel>? meanings;

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      id: json['id'],
      word: json['word'],
      phonetic: json['phonetic'],
      phonetics: parsePhonetics(json['phonetics']),
      origin: json['origin'],
      meanings: parseMeanings(json['meanings']),
    );
  }
  static List<PhoneticsModel> parsePhonetics(placesJson) {
    var list = placesJson as List;
    List<PhoneticsModel> itemList = list.map((data) => PhoneticsModel.fromJson(data)).toList();
    return itemList;
  }
  static List<MeaningsModel> parseMeanings(placesJson) {
    var list = placesJson as List;
    List<MeaningsModel> itemList = list.map((data) => MeaningsModel.fromJson(data)).toList();
    return itemList;
  }
}
class PhoneticsModel {
  PhoneticsModel({this.text});

  String? text;

  factory PhoneticsModel.fromJson(Map<String, dynamic> json) {
    return PhoneticsModel(
      text: json['text'],
    );
  }
}

class MeaningsModel {
  MeaningsModel({this.partOfSpeech, this.definitions});

  String? partOfSpeech;
  List<DefinitionsModel>? definitions;

  factory MeaningsModel.fromJson(Map<String, dynamic> json) {
    return MeaningsModel(
      partOfSpeech: json['partOfSpeech'],
      definitions: parseDefinitions(json['definitions']),
    );
  }


  static List<DefinitionsModel> parseDefinitions(placesJson) {
    var list = placesJson as List;
    List<DefinitionsModel> itemList = list.map((data) => DefinitionsModel.fromJson(data)).toList();
    return itemList;
  }
}

class DefinitionsModel {
  DefinitionsModel({this.definition, this.example, this.synonyms, this.antonyms});

  String? definition;
  String? example;
  String? synonyms;
  String? antonyms;

  factory DefinitionsModel.fromJson(Map<String, dynamic> json) {
    return DefinitionsModel(
      definition: json['definition'],
      example: json['example'],
    );
  }
}