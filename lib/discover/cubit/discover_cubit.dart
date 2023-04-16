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
      final comics = await _marvelRepository.getComics();

      emit(
        state.copyWith(
          status: DiscoverStatus.success,
          comics: comics,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: DiscoverStatus.failure));
    }
  }

  Future<void> refreshComics() async {
    if (!state.status.isSuccess) return;

    emit(
      const DiscoverState(
        status: DiscoverStatus.loading,
      ),
    );

    try {
      final comics = await _marvelRepository.getComics();

      emit(
        state.copyWith(
          status: DiscoverStatus.success,
          comics: comics,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: DiscoverStatus.failure));
    }
  }
}
