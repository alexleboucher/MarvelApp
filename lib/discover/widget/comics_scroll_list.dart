import 'package:flutter/material.dart';
import 'package:marvel_app/discover/discover.dart';
import 'package:marvel_app/shared/widgets/comic_card.dart';
import 'package:marvel_app/shared/widgets/title_see_all.dart';
import 'package:marvel_repository/marvel_repository.dart';

class ComicsScrollList extends StatelessWidget {
  const ComicsScrollList({
    required this.status,
    required this.title,
    super.key,
    this.comics = const [],
  });

  final String title;
  final List<Comic> comics;
  final DiscoverStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TitleSeeAll(title: title),
        ),
        if (![DiscoverStatus.failure, DiscoverStatus.loading].contains(status))
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 250,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              scrollDirection: Axis.horizontal,
              children: comics.map((comic) {
                final index = comics.indexOf(comic);
                final isLast = index == comics.length - 1;
                return ComicCard(
                  comic: comic,
                  margin: !isLast ? const EdgeInsets.only(right: 15) : null,
                );
              }).toList(),
            ),
          ),
        if (status == DiscoverStatus.loading)
          const SizedBox(
            height: 250,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }
}
