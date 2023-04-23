part of 'marvel_api.dart';

extension MarvelComicsApi on MarvelApi {
  Future<ApiResponse<Comic>> getComics({
    int offset = 0,
    int limit = 20,
  }) async {
    final credentials = _getCredentials();
    final request = Uri.https(
      baseUrlMarvel,
      '/v1/public/comics',
      {
        'orderBy': '-modified',
        'apikey': credentials.apiKey,
        'ts': credentials.timestamp,
        'hash': credentials.hash,
        'offset': offset.toString(),
        'limit': limit.toString(),
      },
    );

    final comicsResponse = await _httpClient.get(request);

    if (comicsResponse.statusCode != 200) {
      throw MarvelRequestFailure();
    }

    final comicsJson = jsonDecode(comicsResponse.body) as Map;

    final data = comicsJson['data'] as Map<String, dynamic>;
    final results = data['results'] as List;

    final comics =
        results.map((e) => Comic.fromJson(e as Map<String, dynamic>)).toList();

    return ApiResponse.fromJson(
      data: data,
      results: comics,
    );
  }
}
