part of 'marvel_api.dart';

extension MarvelCharactersApi on MarvelApi {
  Future<List<Character>> getCharacters() async {
    final credentials = _getCredentials();
    final request = Uri.https(
      baseUrlMarvel,
      '/v1/public/characters',
      {
        'orderBy': '-modified',
        'apikey': credentials.apiKey,
        'ts': credentials.timestamp,
        'hash': credentials.hash,
      },
    );

    final charactersResponse = await _httpClient.get(request);

    if (charactersResponse.statusCode != 200) {
      throw MarvelRequestFailure();
    }

    final charactersJson = jsonDecode(charactersResponse.body) as Map;

    final results = (charactersJson['data'] as Map)['results'] as List;

    return results
        .map((e) => Character.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
