import 'package:marvel_api/marvel_api.dart' hide Character, Comic;

import 'package:marvel_repository/marvel_repository.dart';

class MarvelRepository {
  MarvelRepository({required Configuration configuration})
      : _marvelApi = MarvelApi(configuration: configuration);

  final MarvelApi _marvelApi;

  Future<List<Character>> getCharacters() async {
    final characters = await _marvelApi.getCharacters();

    return characters
        .map(
          (character) => Character(
            id: character.id,
            name: character.name,
            description: character.description,
            thumbnailUrl: character.thumbnail != null
                ? '${character.thumbnail!.path}.${character.thumbnail!.extension}'
                : null,
          ),
        )
        .toList();
  }

  Future<List<Comic>> getComics() async {
    final comics = await _marvelApi.getComics();

    return comics
        .map(
          (comic) => Comic(
            id: comic.id,
            title: comic.title,
            description: comic.description,
            thumbnailUrl: comic.thumbnail != null
                ? '${comic.thumbnail!.path}.${comic.thumbnail!.extension}'
                : null,
          ),
        )
        .toList();
  }
}
