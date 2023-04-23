class ApiResponse<T> {
  ApiResponse({
    required this.total,
    required this.results,
  });

  ApiResponse.fromJson({
    required Map<String, dynamic> data,
    required this.results,
  }) : total = data['total'] as int;

  final int total;
  final List<T> results;
}
