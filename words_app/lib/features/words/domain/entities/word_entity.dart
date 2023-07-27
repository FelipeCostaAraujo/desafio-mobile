import 'package:equatable/equatable.dart';

class WordEntity extends Equatable {
  final String word;
  final String definition;
  final String example;
  final String pronunciation;
  final List<String> syllables;

  @override
  List<Object?> get props => [
        word,
        definition,
        example,
        pronunciation,
        syllables,
      ];

  const WordEntity({
    required this.word,
    required this.definition,
    required this.example,
    required this.pronunciation,
    required this.syllables,
  });
}
