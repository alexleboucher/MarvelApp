part of 'discover_cubit.dart';

enum DiscoverStatus { initial, loading, success, failure }

extension DiscoverStatusX on DiscoverStatus {
  bool get isInitial => this == DiscoverStatus.initial;
  bool get isLoading => this == DiscoverStatus.loading;
  bool get isSuccess => this == DiscoverStatus.success;
  bool get isFailure => this == DiscoverStatus.failure;
}

class DiscoverState extends Equatable {
  const DiscoverState({
    this.status = DiscoverStatus.initial,
    this.characters = const [],
  });

  final DiscoverStatus status;
  final List<Character> characters;

  @override
  List<Object> get props => [status, characters];

  DiscoverState copyWith({
    DiscoverStatus? status,
    List<Character>? characters,
  }) {
    return DiscoverState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
    );
  }
}
