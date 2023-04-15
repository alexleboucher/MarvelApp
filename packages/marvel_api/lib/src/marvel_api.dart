import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'package:marvel_api/src/models/character.dart';

const baseUrlMarvel = 'gateway.marvel.com';

class MarvelRequestFailure implements Exception {}

class MarvelApi {
  MarvelApi() : _httpClient = http.Client();

  final http.Client _httpClient;

  Future<List<Character>> getCharacters() async {
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
      print(charactersResponse.body);
      throw MarvelRequestFailure();
    }

    final charactersJson = jsonDecode(charactersResponse.body) as Map;

    final results = (charactersJson['data'] as Map)['results'] as List;

    return results
        .map((e) => Character.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
