import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marvel_app/app/bloc/theme/theme_cubit.dart';
import 'package:marvel_app/app/utils/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, theme) {
          return MaterialApp(
            theme: AppTheme.getTheme(themeMode: theme.themeMode),
            home: const AppView(),
          );
        },
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello World!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            ElevatedButton(
              onPressed: themeCubit.toggleTheme,
              child: Text(
                'Change theme to ${themeCubit.state.themeMode == ThemeMode.light ? 'dark' : 'light'}',
              ),
            )
          ],
        ),
      ),
    );
  }
}
