part of 'marvel_repository.dart';

extension MarvelComicsRepository on MarvelRepository {
  Future<ApiResponse<Comic>> getComics({
    int offset = 0,
    int limit = 20,
    DateDescriptor? dateDescriptor,
    OrderBy orderBy = OrderBy.titleASC,
    FormatType formatType = FormatType.comic,
  }) async {
    final comicsResponse = await _marvelApi.getComics(
      offset: offset,
      limit: limit,
      dateDescriptor: dateDescriptor,
      orderBy: orderBy,
      formatType: formatType,
    );

    final results = <Comic>[];

    for (final comic in comicsResponse.results) {
      final thumbnailUrl = comic.thumbnail != null &&
              !comic.thumbnail!.path.contains('image_not_available')
          ? '${comic.thumbnail!.path}.${comic.thumbnail!.extension}'
          : null;

      results.add(
        Comic(
          id: comic.id,
          title: comic.title,
          description: comic.description,
          thumbnailUrl: thumbnailUrl,
        ),
      );
    }

    // Sort the result show the comics with thumbnail image first
    results.sort((a, b) {
      if (a.thumbnailUrl == b.thumbnailUrl) {
        return 0;
      }
      if (a.thumbnailUrl == null) {
        return 1;
      }
      if (b.thumbnailUrl == null) {
        return -1;
      }
      return 0;
    });

    return ApiResponse(
      total: comicsResponse.total,
      results: results,
    );
  }
}
