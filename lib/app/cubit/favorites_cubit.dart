import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:marvel_repository/marvel_repository.dart';

part 'favorites_state.dart';

class FavoritesCubit extends HydratedCubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

  void addFavoriteComic(Comic comic) {
    emit(
      state.copyWith(
        favoriteComics: [...state.favoriteComics, comic],
      ),
    );
  }

  void removeFavoriteComic(Comic comic) {
    emit(
      state.copyWith(
        favoriteComics:
            state.favoriteComics.where((c) => c.id != comic.id).toList(),
      ),
    );
  }

  @override
  FavoritesState? fromJson(Map<String, dynamic> json) {
    final favoriteComicsJson =
        jsonDecode(json['favoriteComics'] as String) as List;
    final favoriteComics = favoriteComicsJson
        .map((f) => Comic.fromJson(f as Map<String, dynamic>))
        .toList();
    return FavoritesState(
      favoriteComics: favoriteComics,
    );
  }

  @override
  Map<String, dynamic>? toJson(FavoritesState state) {
    return {
      'favoriteComics':
          json.encode(state.favoriteComics.map((e) => e.toJson()).toList()),
    };
  }
}
