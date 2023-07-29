import 'package:equatable/equatable.dart';

class WordEntity extends Equatable {
  final String word;
  final bool isFavorite;
  final String definition;
  final String partOfSpeech;
  final String pronunciation;
  final List<String> synonyms;
  final List<String> typeOf;
  final List<String> hasTypes;
  final List<String> derivation;
  final List<String> examples;

  const WordEntity({
    required this.word,
    this.isFavorite = false,
    required this.definition,
    required this.partOfSpeech,
    required this.synonyms,
    required this.typeOf,
    required this.hasTypes,
    required this.derivation,
    required this.examples,
    required this.pronunciation,
  });

  @override
  List<Object?> get props => [
        definition,
        isFavorite,
        partOfSpeech,
        synonyms,
        typeOf,
        hasTypes,
        derivation,
        examples,
        word,
        pronunciation,
      ];

  WordEntity copyWith({
    String? word,
    bool? isFavorite,
    String? definition,
    String? partOfSpeech,
    String? pronunciation,
    List<String>? synonyms,
    List<String>? typeOf,
    List<String>? hasTypes,
    List<String>? derivation,
    List<String>? examples,
  }) {
    return WordEntity(
      word: word ?? this.word,
      isFavorite: isFavorite ?? this.isFavorite,
      definition: definition ?? this.definition,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      pronunciation: pronunciation ?? this.pronunciation,
      synonyms: synonyms ?? this.synonyms,
      typeOf: typeOf ?? this.typeOf,
      hasTypes: hasTypes ?? this.hasTypes,
      derivation: derivation ?? this.derivation,
      examples: examples ?? this.examples,
    );
  }

  Map<String, dynamic> toJSon() {
    return {
      "word": word,
      "isFavorite": isFavorite,
      "definition": definition,
      "partOfSpeech": partOfSpeech,
      "pronunciation": pronunciation,
      "synonyms": synonyms,
      "typeOf": typeOf,
      "hasTypes": hasTypes,
      "derivation": derivation,
      "examples": examples,
    };
  }

  factory WordEntity.fromJson(Map<String, dynamic> json) {
    return WordEntity(
      word: json["word"],
      isFavorite: json["isFavorite"],
      definition: json["definition"],
      partOfSpeech: json["partOfSpeech"],
      pronunciation: json["pronunciation"],
      synonyms: json["synonyms"],
      typeOf: json["typeOf"],
      hasTypes: json["hasTypes"],
      derivation: json["derivation"],
      examples: json["examples"],
    );
  }
}
