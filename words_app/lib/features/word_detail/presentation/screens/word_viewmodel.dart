import 'package:equatable/equatable.dart';

class WordViewModel extends Equatable {
  final String word;
  final String definition;
  final String example;
  final String pronunciation;

  const WordViewModel({
    required this.word,
    required this.definition,
    required this.example,
    required this.pronunciation,
  });

  @override
  List<Object?> get props => [word, definition, example, pronunciation];
}
