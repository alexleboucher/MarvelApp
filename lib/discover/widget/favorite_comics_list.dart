import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:marvel_app/app/cubit/favorites_cubit.dart';
import 'package:marvel_app/home/home.dart';
import 'package:marvel_app/shared/widgets/comic_card.dart';
import 'package:marvel_app/shared/widgets/title_see_all.dart';

class FavoriteComicsList extends StatelessWidget {
  const FavoriteComicsList({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TitleSeeAll(
                title: 'Your favorites',
                onSeeAllClick: () => homeCubit.setTab(HomeTab.favorites),
              ),
            ),
            if (!state.favoriteStatus.isLoading &&
                !state.favoriteStatus.isFailure)
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 250,
                child: state.favoriteComics.isNotEmpty
                    ? ListView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        scrollDirection: Axis.horizontal,
                        children: state.favoriteComics.map((comic) {
                          final index = state.favoriteComics.indexOf(comic);
                          final isLast =
                              index == state.favoriteComics.length - 1;
                          return ComicCard(
                            comic: comic,
                            margin: !isLast
                                ? const EdgeInsets.only(right: 15)
                                : null,
                          );
                        }).toList(),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            textAlign: TextAlign.center,
                            "You don't have any favorites yet.",
                          ),
                          Gap(5),
                          Text(
                            textAlign: TextAlign.center,
                            'To save a favorite, touch and hold a comic card.',
                          ),
                        ],
                      ),
              ),
            if (state.favoriteStatus.isLoading)
              const SizedBox(
                height: 250,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        );
      },
    );
  }
}
