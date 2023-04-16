import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_api/marvel_api.dart';

part 'marvel_characters_api.dart';
part 'marvel_comics_api.dart';

const baseUrlMarvel = 'gateway.marvel.com';

class Configuration {
  const Configuration({
    required this.publicApiKey,
    required this.privateApiKey,
  });

  final String publicApiKey;
  final String privateApiKey;
}

class Credentials {
  const Credentials({
    required this.timestamp,
    required this.apiKey,
    required this.hash,
  });

  final String timestamp;
  final String apiKey;
  final String hash;
}

class MarvelRequestFailure implements Exception {}

class MarvelApi {
  MarvelApi({required this.configuration}) : _httpClient = http.Client();

  final Configuration configuration;
  final http.Client _httpClient;

  Credentials _getCredentials() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final apikey = configuration.publicApiKey;
    final apiHash = md5
        .convert(utf8.encode('$timestamp${configuration.privateApiKey}$apikey'))
        .toString();

    return Credentials(timestamp: timestamp, apiKey: apikey, hash: apiHash);
  }
}
