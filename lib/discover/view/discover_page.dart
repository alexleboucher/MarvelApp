import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:marvel_app/discover/discover.dart';
import 'package:marvel_app/shared/widgets/comic_card.dart';
import 'package:marvel_app/shared/widgets/title_see_all.dart';
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
    return BlocBuilder<DiscoverCubit, DiscoverState>(
      builder: (context, state) {
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TitleSeeAll(title: 'New this week'),
              ),
              if (![DiscoverStatus.failure, DiscoverStatus.loading]
                  .contains(state.status))
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 230,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    scrollDirection: Axis.horizontal,
                    children: state.comics.map((comic) {
                      final index = state.comics.indexOf(comic);
                      final isLast = index == state.comics.length;
                      return ComicCard(
                        imageUrl: comic.thumbnailUrl,
                        title: comic.title,
                        margin:
                            !isLast ? const EdgeInsets.only(right: 25) : null,
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
