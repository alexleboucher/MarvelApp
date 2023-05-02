import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:marvel_app/app/cubit/favorites_cubit.dart';
import 'package:marvel_app/shared/widgets/multiple_lines_text.dart';
import 'package:marvel_repository/marvel_repository.dart';

class ComicCard extends StatelessWidget {
  const ComicCard({
    required this.comic,
    this.margin,
    super.key,
  });

  final Comic comic;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.w600,
        );

    void handleLongPress() {
      final favoritesCubit = context.read<FavoritesCubit>();
      final isFavorite =
          favoritesCubit.state.favoriteComics.any((c) => c.id == comic.id);
      if (!isFavorite) {
        favoritesCubit.addFavoriteComic(comic);
      } else {
        favoritesCubit.removeFavoriteComic(comic);
      }
    }

    return GestureDetector(
      onLongPress: handleLongPress,
      child: Container(
        margin: margin,
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.shadow,
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: comic.thumbnailUrl != null
                        ? Image.network(
                            comic.thumbnailUrl!,
                            loadingBuilder: (
                              BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress,
                            ) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          )
                        : Image.asset('assets/images/no_cover.jpg'),
                  ),
                ),
              ),
            ),
            const Gap(10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: MultipleLinesText(
                comic.title,
                style: titleStyle,
                maxLines: 2,
                minLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
