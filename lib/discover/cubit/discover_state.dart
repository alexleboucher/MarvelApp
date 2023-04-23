part of 'discover_cubit.dart';

enum DiscoverStatus { initial, loading, loadingMore, success, failure }

extension DiscoverStatusX on DiscoverStatus {
  bool get isInitial => this == DiscoverStatus.initial;
  bool get isLoading => this == DiscoverStatus.loading;
  bool get isLoadingMore => this == DiscoverStatus.loadingMore;
  bool get isSuccess => this == DiscoverStatus.success;
  bool get isFailure => this == DiscoverStatus.failure;
}

class DiscoverState extends Equatable {
  const DiscoverState({
    this.status = DiscoverStatus.initial,
    this.comics = const [],
    this.total = 0,
  });

  final DiscoverStatus status;
  final List<Comic> comics;
  final int total;

  @override
  List<Object> get props => [status, comics];

  DiscoverState copyWith({
    DiscoverStatus? status,
    List<Comic>? comics,
    int? total,
  }) {
    return DiscoverState(
      status: status ?? this.status,
      comics: comics ?? this.comics,
      total: total ?? this.total,
    );
  }
}
