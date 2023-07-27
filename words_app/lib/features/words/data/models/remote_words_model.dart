class RemoteWordsModel {
  final List<String> words;

  RemoteWordsModel({required this.words});

  factory RemoteWordsModel.fromJson(Map<String, dynamic> json) {
    return RemoteWordsModel(words: json['words'].cast<String>());
  }
}
