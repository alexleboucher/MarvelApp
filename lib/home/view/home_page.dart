import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/app/app.dart';
import 'package:marvel_app/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode =
        context.select((ThemeCubit cubit) => cubit.state.themeMode);
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
              onPressed: context.read<ThemeCubit>().toggleTheme,
              child: Text(
                'Change theme to ${themeMode == ThemeMode.light ? 'dark' : 'light'}',
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBottomBar(),
    );
  }
}
