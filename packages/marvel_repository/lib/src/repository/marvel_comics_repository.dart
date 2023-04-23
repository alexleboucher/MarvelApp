part of 'marvel_repository.dart';

extension MarvelComicsRepository on MarvelRepository {
  Future<ApiResponse<Comic>> getComics({
    int offset = 0,
    int limit = 20,
  }) async {
    final comicsResponse = await _marvelApi.getComics(
      offset: offset,
      limit: limit,
    );

    final results = <Comic>[];

    for (final comic in comicsResponse.results) {
      final thumbnailUrl = comic.thumbnail != null
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

    return ApiResponse(
      total: comicsResponse.total,
      results: results,
    );
  }
}
