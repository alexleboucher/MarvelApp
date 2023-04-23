import 'package:marvel_api/marvel_api.dart' hide Character, Comic;

import 'package:marvel_repository/marvel_repository.dart';

part 'marvel_comics_repository.dart';
part 'marvel_characters_repository.dart';

class MarvelRepository {
  MarvelRepository({required Configuration configuration})
      : _marvelApi = MarvelApi(configuration: configuration);

  final MarvelApi _marvelApi;
}
