part of 'marvel_api.dart';

extension MarvelComicsApi on MarvelApi {
  Future<List<Character>> getComics() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    const apikey = 'cf07a492c20e21a5319e53da7f66a823';
    final hash = md5
        .convert(utf8.encode(
            '${timestamp}48c8ee51a85fe4d75488558ff0f15a2fa07283f5$apikey'))
        .toString();
    final request = Uri.https(
      baseUrlMarvel,
      '/v1/public/characters',
      {
        'orderBy': '-modified',
        'apikey': apikey,
        'ts': timestamp,
        'hash': hash,
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
