class RemoteResultsModel {
  final String? definition;
  final String? partOfSpeech;
  final List<String>? synonyms;
  final List<String>? typeOf;
  final List<String>? hasTypes;
  final List<String>? derivation;
  final List<String>? examples;

  const RemoteResultsModel({
    this.definition,
    this.partOfSpeech,
    this.synonyms,
    this.typeOf,
    this.hasTypes,
    this.derivation,
    this.examples,
  });

  Map<String, dynamic> toJson() {
    return {
      'definition': definition,
      'partOfSpeech': partOfSpeech,
      'synonyms': synonyms,
      'typeOf': typeOf,
      'hasTypes': hasTypes,
      'derivation': derivation,
      'examples': examples,
    };
  }

  factory RemoteResultsModel.fromJson(Map<String, dynamic> json) =>
      RemoteResultsModel(
        definition: json['definition'],
        partOfSpeech: json['partOfSpeech'],
        synonyms: json['synonyms'] != null
            ? (json['synonyms'] as List).map((e) => e.toString()).toList()
            : null,
        typeOf: json['typeOf'] != null
            ? (json['typeOf'] as List).map((e) => e.toString()).toList()
            : null,
        hasTypes: json['hasTypes'] != null
            ? (json['hasTypes'] as List).map((e) => e.toString()).toList()
            : null,
        derivation: json['derivation'] != null
            ? (json['derivation'] as List).map((e) => e.toString()).toList()
            : null,
        examples: json['examples'] != null
            ? (json['examples'] as List).map((e) => e.toString()).toList()
            : null,
      );
}
