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
    this.comicsNewThisWeekStatus = DiscoverStatus.initial,
    this.comicsReleasedLastWeekStatus = DiscoverStatus.initial,
    this.comicsNewThisWeek = const [],
    this.comicsReleasedLastWeek = const [],
  });

  final DiscoverStatus comicsNewThisWeekStatus;
  final DiscoverStatus comicsReleasedLastWeekStatus;
  final List<Comic> comicsNewThisWeek;
  final List<Comic> comicsReleasedLastWeek;

  @override
  List<Object> get props => [
        comicsNewThisWeekStatus,
        comicsReleasedLastWeekStatus,
        comicsNewThisWeek,
        comicsReleasedLastWeek,
      ];

  DiscoverState copyWith({
    DiscoverStatus? comicsNewThisWeekStatus,
    DiscoverStatus? comicsReleasedLastWeekStatus,
    List<Comic>? comicsNewThisWeek,
    List<Comic>? comicsReleasedLastWeek,
  }) {
    return DiscoverState(
      comicsNewThisWeekStatus:
          comicsNewThisWeekStatus ?? this.comicsNewThisWeekStatus,
      comicsReleasedLastWeekStatus:
          comicsReleasedLastWeekStatus ?? this.comicsReleasedLastWeekStatus,
      comicsNewThisWeek: comicsNewThisWeek ?? this.comicsNewThisWeek,
      comicsReleasedLastWeek:
          comicsReleasedLastWeek ?? this.comicsReleasedLastWeek,
    );
  }
}
