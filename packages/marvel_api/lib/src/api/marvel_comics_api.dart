part of 'marvel_api.dart';

extension MarvelComicsApi on MarvelApi {
  Future<List<Comic>> getComics() async {
    final credentials = _getCredentials();
    final request = Uri.https(
      baseUrlMarvel,
      '/v1/public/comics',
      {
        'orderBy': '-modified',
        'apikey': credentials.apiKey,
        'ts': credentials.timestamp,
        'hash': credentials.hash,
      },
    );

    final comicsResponse = await _httpClient.get(request);

    if (comicsResponse.statusCode != 200) {
      throw MarvelRequestFailure();
    }

    final comicsJson = jsonDecode(comicsResponse.body) as Map;

    final results = (comicsJson['data'] as Map)['results'] as List;

    return results
        .map((e) => Comic.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
