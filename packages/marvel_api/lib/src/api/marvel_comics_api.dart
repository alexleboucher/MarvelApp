part of 'marvel_api.dart';

enum DateDescriptor { lastWeek, thisWeek, nextWeek, thisMonth }

enum FormatType { comic, collection }

enum OrderBy {
  focDateASC,
  onsaleDateASC,
  titleASC,
  issueNumberASC,
  modifiedASC,
  focDateDESC,
  onsaleDateDESC,
  titleDESC,
  issueNumberDESC,
  modifiedDESC,
}

extension ParseToString on OrderBy {
  String parseToString() {
    var value = name;
    if (value.contains('ASC')) {
      value = value.replaceFirst('ASC', '');
    }
    if (value.contains('DESC')) {
      value = value.replaceFirst('DESC', '');
      value = '-$value';
    }
    return value;
  }
}

extension MarvelComicsApi on MarvelApi {
  Future<ApiResponse<Comic>> getComics({
    int offset = 0,
    int limit = 20,
    DateDescriptor? dateDescriptor,
    OrderBy orderBy = OrderBy.titleASC,
    FormatType formatType = FormatType.comic,
    bool noVariants = true,
    int? startYear,
    int? issueNumber,
  }) async {
    final credentials = _getCredentials();
    final request = Uri.https(
      baseUrlMarvel,
      '/v1/public/comics',
      {
        'apikey': credentials.apiKey,
        'ts': credentials.timestamp,
        'hash': credentials.hash,
        'offset': offset.toString(),
        'limit': limit.toString(),
        'orderBy': orderBy.parseToString(),
        'formatType': formatType.name,
        'noVariants': noVariants.toString(),
        if (dateDescriptor != null) 'dateDescriptor': dateDescriptor.name,
        if (startYear != null) 'startYear': startYear.toString(),
        if (issueNumber != null) 'issueNumber': issueNumber.toString(),
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
