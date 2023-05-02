import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                            'Your favorite comics (${state.favoriteComics.length})',
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
                                .map((e) => ComicCard(comic: e))
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
