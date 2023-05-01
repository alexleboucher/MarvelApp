class Comic {
  const Comic({
    required this.id,
    required this.title,
    this.description,
    this.thumbnailUrl,
  });

  final int id;
  final String title;
  final String? description;
  final String? thumbnailUrl;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  // ignore: prefer_constructors_over_static_methods
  static Comic fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );
  }
}
