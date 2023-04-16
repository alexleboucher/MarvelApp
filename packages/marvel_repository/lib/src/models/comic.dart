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
}
