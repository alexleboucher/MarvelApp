import 'package:marvel_api/marvel_api.dart' hide Character;

import 'package:marvel_repository/marvel_repository.dart';

class MarvelRepository {
  MarvelRepository() : _marvelApi = MarvelApi();

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
}
