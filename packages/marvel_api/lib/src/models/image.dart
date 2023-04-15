class Image {
  const Image({
    required this.path,
    required this.extension,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      path: json['path'] as String,
      extension: json['extension'] as String,
    );
  }

  final String path;
  final String extension;
}
