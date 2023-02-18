class AIModel {
  final String id;
  final String root;
  final int createdAt;

  AIModel({
    required this.id,
    required this.root,
    required this.createdAt,
  });

  factory AIModel.fromJson(Map<String, dynamic> json) {
    return AIModel(
      id: json['id'],
      root: json['root'],
      createdAt: json['created'],
    );
  }

  static List<AIModel> getAIModels(List modelsJson) {
    return modelsJson.map((model) => AIModel.fromJson(model)).toList();
  }
}
