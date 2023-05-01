import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:marvel_app/app/cubit/favorites_cubit.dart';

import 'package:marvel_app/discover/discover.dart';
import 'package:marvel_app/discover/widget/comics_scroll_list.dart';
import 'package:marvel_repository/marvel_repository.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DiscoverCubit(context.read<MarvelRepository>()),
      child: const DiscoverView(),
    );
  }
}

class DiscoverView extends StatelessWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('assets/images/marvel_discover.png'),
            ),
          ),
          const Gap(20),
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              return Column(
                children: [
                  ComicsScrollList(
                    title: 'Your favorites',
                    status: DiscoverStatus.success,
                    comics: state.favoriteComics,
                  ),
                ],
              );
            },
          ),
          const Gap(20),
          BlocBuilder<DiscoverCubit, DiscoverState>(
            builder: (context, state) {
              return Column(
                children: [
                  ComicsScrollList(
                    title: 'New this week',
                    status: state.comicsNewThisWeekStatus,
                    comics: state.comicsNewThisWeek,
                  ),
                  const Gap(20),
                  ComicsScrollList(
                    title: 'Released last week',
                    status: state.comicsReleasedLastWeekStatus,
                    comics: state.comicsReleasedLastWeek,
                  ),
                ],
              );
            },
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
