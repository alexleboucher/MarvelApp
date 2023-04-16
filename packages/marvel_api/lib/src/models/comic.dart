import 'package:marvel_api/marvel_api.dart';

class Comic {
  const Comic({
    required this.id,
    required this.title,
    this.description,
    this.thumbnail,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] != null
          ? Image.fromJson(json['thumbnail'] as Map<String, dynamic>)
          : null,
    );
  }

  final int id;
  final String title;
  final String? description;
  final Image? thumbnail;
}
