class WordViewModel {
  final String word;
  final String definition;
  final String example;
  final String pronunciation;
  bool isFavorite;

  WordViewModel({
    required this.word,
    required this.definition,
    required this.example,
    required this.pronunciation,
    this.isFavorite = false,
  });
}
