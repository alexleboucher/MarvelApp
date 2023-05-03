import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:marvel_app/app/cubit/favorites_cubit.dart';
import 'package:marvel_app/shared/widgets/comic_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
        );
    final state = context.select((FavoritesCubit cubit) => cubit.state);
    final favoriteComicsTotal = state.favoriteComics.length;

    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!state.favoriteStatus.isLoading &&
                    !state.favoriteStatus.isFailure) ...[
                  ...state.favoriteComics.isNotEmpty
                      ? [
                          Text(
                            AppLocalizations.of(context)!
                                .yourFavoritesComics(favoriteComicsTotal),
                            style: titleStyle,
                          ),
                          const Gap(25),
                          GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: 0.6,
                            mainAxisSpacing: 25,
                            crossAxisSpacing: 12,
                            shrinkWrap: true,
                            children: state.favoriteComics
                                .map(
                                  (e) => ComicCard(
                                    comic: e,
                                    canRemoveFavorite: true,
                                  ),
                                )
                                .toList(),
                          ),
                          const Gap(20),
                        ]
                      : [
                          ConstrainedBox(
                            constraints:
                                BoxConstraints(minHeight: constraint.maxHeight),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .noFavoritesYet,
                                    textAlign: TextAlign.center,
                                  ),
                                  const Gap(5),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .saveFavoriteHint,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]
                ],
                if (state.favoriteStatus.isLoading)
                  ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
