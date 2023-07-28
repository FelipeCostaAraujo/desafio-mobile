class RemoteSyllablesModel {
  final int? count;
  final List<String>? list;

  const RemoteSyllablesModel({
    this.count,
    this.list,
  });

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'list': list,
    };
  }

  factory RemoteSyllablesModel.fromJson(Map<String, dynamic> json) {
    return RemoteSyllablesModel(
      count: json['count'] ?? 0,
      list: json['list'] != null
          ? (json['list'] as List).map((e) => e.toString()).toList()
          : null,
    );
  }
}
