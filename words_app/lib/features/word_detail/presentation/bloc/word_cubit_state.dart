import 'package:words_app/features/word_detail/domain/entities/word_entity.dart';

enum WordStateStatus { loading, loaded, error }

class WordCubitState {
  final WordStateStatus status;
  final WordEntity? word;
  final String? error;

  const WordCubitState({
    required this.status,
    this.word,
    this.error,
  });

  WordCubitState copyWith({
    WordStateStatus? status,
    WordEntity? word,
    String? error,
  }) {
    return WordCubitState(
      status: status ?? this.status,
      word: word ?? this.word,
      error: error ?? this.error,
    );
  }
}
