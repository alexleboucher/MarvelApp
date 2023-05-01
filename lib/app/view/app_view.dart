import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:marvel_app/app/app.dart';
import 'package:marvel_app/app/cubit/favorites_cubit.dart';
import 'package:marvel_app/home/home.dart';
import 'package:marvel_repository/marvel_repository.dart';

class App extends StatelessWidget {
  App({super.key})
      : _marvelRepository = MarvelRepository(
          configuration: Configuration(
            // ignore: cast_nullable_to_non_nullable
            publicApiKey: dotenv.env['MARVEL_PUBLIC_KEY'] as String,
            // ignore: cast_nullable_to_non_nullable
            privateApiKey: dotenv.env['MARVEL_PRIVATE_KEY'] as String,
          ),
        );

  final MarvelRepository _marvelRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _marvelRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ThemeCubit(),
          ),
          BlocProvider(
            create: (_) => FavoritesCubit(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, theme) {
            return MaterialApp(
              theme: AppTheme.getTheme(themeMode: theme.themeMode),
              home: const HomePage(),
            );
          },
        ),
      ),
    );
  }
}
