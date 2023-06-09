import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_repository/marvel_repository.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit(this._marvelRepository) : super(const DiscoverState()) {
    fetchNewThisWeekComics();
    fetchReleasedLastWeekComics();
    fetchStartedThisYearComics();
  }

  final MarvelRepository _marvelRepository;

  Future<void> fetchNewThisWeekComics() async {
    emit(
      state.copyWith(
        comicsNewThisWeekStatus: DiscoverStatus.loading,
        comicsNewThisWeek: [],
      ),
    );

    try {
      final comicsResponse = await _marvelRepository.getComics(
        dateDescriptor: DateDescriptor.thisWeek,
        orderBy: OrderBy.onsaleDateASC,
      );

      emit(
        state.copyWith(
          comicsNewThisWeekStatus: DiscoverStatus.success,
          comicsNewThisWeek: comicsResponse.results,
        ),
      );
    } on Exception {
      emit(state.copyWith(comicsNewThisWeekStatus: DiscoverStatus.failure));
    }
  }

  Future<void> fetchReleasedLastWeekComics() async {
    emit(
      state.copyWith(
        comicsReleasedLastWeekStatus: DiscoverStatus.loading,
        comicsReleasedLastWeek: [],
      ),
    );

    try {
      final comicsResponse = await _marvelRepository.getComics(
        dateDescriptor: DateDescriptor.lastWeek,
        orderBy: OrderBy.onsaleDateASC,
      );

      emit(
        state.copyWith(
          comicsReleasedLastWeekStatus: DiscoverStatus.success,
          comicsReleasedLastWeek: comicsResponse.results,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(comicsReleasedLastWeekStatus: DiscoverStatus.failure),
      );
    }
  }

  Future<void> fetchStartedThisYearComics() async {
    emit(
      state.copyWith(
        comicsStartedThisYearStatus: DiscoverStatus.loading,
        comicsStartedThisYear: [],
      ),
    );

    try {
      final comicsResponse = await _marvelRepository.getComics(
        orderBy: OrderBy.focDateASC,
        startYear: DateTime.now().year,
        issueNumber: 1,
      );

      emit(
        state.copyWith(
          comicsStartedThisYearStatus: DiscoverStatus.success,
          comicsStartedThisYear: comicsResponse.results,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(comicsStartedThisYearStatus: DiscoverStatus.failure),
      );
    }
  }
}
