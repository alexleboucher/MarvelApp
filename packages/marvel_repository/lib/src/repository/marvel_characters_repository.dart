part of 'marvel_repository.dart';

extension MarvelCharactersRepository on MarvelRepository {
  Future<ApiResponse<Character>> getCharacters({
    int offset = 0,
    int limit = 20,
  }) async {
    final charactersResponse = await _marvelApi.getCharacters(
      offset: offset,
      limit: limit,
    );

    final results = <Character>[];

    for (final character in charactersResponse.results) {
      final thumbnailUrl = character.thumbnail != null
          ? '${character.thumbnail!.path}.${character.thumbnail!.extension}'
          : null;

      results.add(
        Character(
          id: character.id,
          name: character.name,
          description: character.description,
          thumbnailUrl: thumbnailUrl,
        ),
      );
    }

    return ApiResponse(
      total: charactersResponse.total,
      results: results,
    );
  }
}
