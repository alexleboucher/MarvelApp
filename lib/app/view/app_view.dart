import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel_app/app/app.dart';
import 'package:marvel_app/app/cubit/favorites_cubit.dart';
import 'package:marvel_app/home/home.dart';
import 'package:marvel_app/settings/view/settings_page.dart';
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

  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => const HomePage(),
        '/settings': (context, state, data) => const SettingsPage(),
      },
    ).call,
  );

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _marvelRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SettingsCubit(),
          ),
          BlocProvider(
            create: (_) => FavoritesCubit(),
          ),
        ],
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settings) {
            return MaterialApp.router(
              theme: AppTheme.getTheme(themeMode: settings.themeMode),
              routerDelegate: routerDelegate,
              routeInformationParser: BeamerParser(),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: settings.locale,
            );
          },
        ),
      ),
    );
  }
}
