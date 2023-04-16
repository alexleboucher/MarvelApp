import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:marvel_app/app/app.dart';
import 'package:marvel_app/home/home.dart';
import 'package:marvel_repository/marvel_repository.dart';

class App extends StatelessWidget {
  App({super.key})
      : _marvelRepository = MarvelRepository(
          configuration: Configuration(
            publicApiKey: dotenv.env['MARVEL_PUBLIC_KEY'] as String,
            privateApiKey: dotenv.env['MARVEL_PRIVATE_KEY'] as String,
          ),
        );

  final MarvelRepository _marvelRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _marvelRepository,
      child: BlocProvider(
        create: (_) => ThemeCubit(),
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
