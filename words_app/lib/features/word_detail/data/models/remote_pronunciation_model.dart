class RemotePronunciationModel {
  final String? all;

  const RemotePronunciationModel({
    this.all,
  });

  static Map<String, dynamic> toJson(RemotePronunciationModel? e) {
    return {
      'all': e?.all,
    };
  }

  factory RemotePronunciationModel.fromJson(Map<String, dynamic> json) {
    return RemotePronunciationModel(
      all: json['all'],
    );
  }
}
