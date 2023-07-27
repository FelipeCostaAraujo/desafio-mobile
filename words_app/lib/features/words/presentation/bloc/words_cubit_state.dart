enum WordsStateStatus { loading, loaded, error }

class WordsCubitState {
  const WordsCubitState({
    required this.status,
    this.words = const [],
    this.error,
  });

  final WordsStateStatus status;
  final List<String> words;
  final String? error;

  WordsCubitState copyWith({
    WordsStateStatus? status,
    List<String>? words,
    String? error,
  }) {
    return WordsCubitState(
      status: status ?? this.status,
      error: error ?? this.error,
      words: words ?? this.words,
    );
  }
}
