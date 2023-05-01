part of 'favorites_cubit.dart';

enum FavoritesStatus { loading, success, failure }

extension FavoritesStatusX on FavoritesStatus {
  bool get isLoading => this == FavoritesStatus.loading;
  bool get isSuccess => this == FavoritesStatus.success;
  bool get isFailure => this == FavoritesStatus.failure;
}

class FavoritesState extends Equatable {
  const FavoritesState({
    this.favoriteComics = const [],
    this.favoriteStatus = FavoritesStatus.loading,
  });

  final List<Comic> favoriteComics;
  final FavoritesStatus favoriteStatus;

  @override
  List<Object> get props => [favoriteComics];

  FavoritesState copyWith({
    List<Comic>? favoriteComics,
    FavoritesStatus? favoriteStatus,
  }) {
    return FavoritesState(
      favoriteComics: favoriteComics ?? this.favoriteComics,
      favoriteStatus: favoriteStatus ?? this.favoriteStatus,
    );
  }
}
