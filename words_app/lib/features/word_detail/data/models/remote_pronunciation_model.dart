class RemotePronunciationModel {
  final String? all;

  const RemotePronunciationModel({
    this.all,
  });

  Map<String, dynamic> toJson() {
    return {'all': all};
  }

  factory RemotePronunciationModel.fromJson(Map<String, dynamic> json) {
    return RemotePronunciationModel(
      all: json['all'],
    );
  }
}
