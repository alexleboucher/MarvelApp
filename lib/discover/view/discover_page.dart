import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marvel_app/app/app.dart';
import 'package:marvel_app/discover/discover.dart';
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
    final themeMode =
        context.select((ThemeCubit cubit) => cubit.state.themeMode);
    return BlocBuilder<DiscoverCubit, DiscoverState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () => context.read<DiscoverCubit>().refreshComics(),
          child: Column(
            children: [
              if (state.status.isLoading) const Text('Loading...'),
              if (state.status.isSuccess)
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Column(
                      children: state.comics.map((e) => Text(e.title)).toList(),
                    ),
                  ),
                ),
              Center(
                child: ElevatedButton(
                  onPressed: context.read<ThemeCubit>().toggleTheme,
                  child: Text(
                    'Change theme to ${themeMode == ThemeMode.light ? 'dark' : 'light'}',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
