import 'package:equatable/equatable.dart';

class WordEntity extends Equatable {
  final String word;
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
    partOfSpeech,
    synonyms,
    typeOf,
    hasTypes,
    derivation,
    examples,
    word,
    pronunciation,
  ];
}