import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_repository/marvel_repository.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit(this._marvelRepository) : super(const DiscoverState()) {
    fetchComics();
  }

  final MarvelRepository _marvelRepository;

  Future<void> fetchComics() async {
    emit(const DiscoverState(status: DiscoverStatus.loading));

    try {
      final comicsResponse = await _marvelRepository.getComics();

      emit(
        state.copyWith(
          status: DiscoverStatus.success,
          comics: comicsResponse.results,
          total: comicsResponse.total,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: DiscoverStatus.failure));
    }
  }

  Future<void> fetchMoreComics() async {
    emit(state.copyWith(status: DiscoverStatus.loading));

    try {
      final comicsResponse =
          await _marvelRepository.getComics(offset: state.comics.length);

      emit(
        state.copyWith(
          status: DiscoverStatus.success,
          comics: [...state.comics, ...comicsResponse.results],
          total: comicsResponse.total,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: DiscoverStatus.failure));
    }
  }

  Future<void> refreshComics() async {
    if (!state.status.isSuccess) return;
    await fetchComics();
  }
}
