part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  const FavoritesState({
    this.favoriteComics = const [],
  });

  final List<Comic> favoriteComics;

  @override
  List<Object> get props => [favoriteComics];

  FavoritesState copyWith({
    List<Comic>? favoriteComics,
  }) {
    return FavoritesState(
      favoriteComics: favoriteComics ?? this.favoriteComics,
    );
  }
}
