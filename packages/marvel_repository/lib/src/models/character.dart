class Character {
  const Character({
    required this.id,
    required this.name,
    this.description,
    this.thumbnailUrl,
  });

  final int id;
  final String name;
  final String? description;
  final String? thumbnailUrl;
}
