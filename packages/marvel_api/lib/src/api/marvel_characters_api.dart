part of 'marvel_api.dart';

extension MarvelCharactersApi on MarvelApi {
  Future<ApiResponse<Character>> getCharacters({
    int offset = 0,
    int limit = 20,
  }) async {
    final credentials = _getCredentials();
    final request = Uri.https(
      baseUrlMarvel,
      '/v1/public/characters',
      {
        'orderBy': '-modified',
        'apikey': credentials.apiKey,
        'ts': credentials.timestamp,
        'hash': credentials.hash,
        'offset': offset,
        'limit': limit,
      },
    );

    final charactersResponse = await _httpClient.get(request);

    if (charactersResponse.statusCode != 200) {
      throw MarvelRequestFailure();
    }

    final charactersJson = jsonDecode(charactersResponse.body) as Map;

    final data = charactersJson['data'] as Map<String, dynamic>;
    final results = data['results'] as List;

    final characters = results
        .map((e) => Character.fromJson(e as Map<String, dynamic>))
        .toList();

    return ApiResponse.fromJson(
      data: data,
      results: characters,
    );
  }
}
