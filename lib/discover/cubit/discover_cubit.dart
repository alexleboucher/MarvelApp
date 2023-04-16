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
      final characters = await _marvelRepository.getCharacters();

      emit(
        state.copyWith(
          status: DiscoverStatus.success,
          characters: characters,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: DiscoverStatus.failure));
    }
  }
}
