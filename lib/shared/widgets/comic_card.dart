import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:marvel_app/app/cubit/favorites_cubit.dart';
import 'package:marvel_app/shared/widgets/animated_heart.dart';
import 'package:marvel_app/shared/widgets/multiple_lines_text.dart';
import 'package:marvel_repository/marvel_repository.dart';

class ComicCard extends StatefulWidget {
  const ComicCard({
    required this.comic,
    this.margin,
    this.canRemoveFavorite = false,
    super.key,
  });

  final Comic comic;
  final EdgeInsetsGeometry? margin;
  final bool canRemoveFavorite;

  @override
  State<ComicCard> createState() => _ComicCardState();
}

class _ComicCardState extends State<ComicCard> {
  bool _isHeartAnimating = false;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.w600,
        );

    void handleDoubleTap() {
      final favoritesCubit = context.read<FavoritesCubit>();
      final isFavorite = favoritesCubit.state.favoriteComics
          .any((c) => c.id == widget.comic.id);

      // If we can't remove favorite, we show the animation
      // even if it's already a favorite comic
      if (!isFavorite || !widget.canRemoveFavorite) {
        setState(() {
          _isHeartAnimating = true;
        });
      }

      if (!isFavorite) {
        favoritesCubit.addFavoriteComic(widget.comic);
      } else if (widget.canRemoveFavorite) {
        favoritesCubit.removeFavoriteComic(widget.comic);
      }
    }

    return GestureDetector(
      onDoubleTap: handleDoubleTap,
      child: Container(
        margin: widget.margin,
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
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: widget.comic.thumbnailUrl != null
                            ? Image.network(
                                widget.comic.thumbnailUrl!,
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
                      Opacity(
                        opacity: _isHeartAnimating ? 1 : 0,
                        child: AnimatedHeart(
                          isAnimating: _isHeartAnimating,
                          onAnimationEnd: () {
                            setState(() {
                              _isHeartAnimating = false;
                            });
                          },
                          duration: const Duration(milliseconds: 500),
                          child: Icon(
                            Icons.favorite,
                            size: 45,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: MultipleLinesText(
                widget.comic.title,
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
