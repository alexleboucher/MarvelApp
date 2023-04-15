import 'package:marvel_api/marvel_api.dart';

class Character {
  const Character({
    required this.id,
    required this.name,
    this.description,
    this.thumbnail,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] != null
          ? Image.fromJson(json['thumbnail'] as Map<String, dynamic>)
          : null,
    );
  }

  final int id;
  final String name;
  final String? description;
  final Image? thumbnail;
}
