import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/app/app.dart';
import 'package:marvel_app/home/home.dart';
import 'package:marvel_repository/marvel_repository.dart';

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

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late List<Character> _characters = [];

  Future<void> getCharacters() async {
    final characters = await MarvelRepository().getCharacters();
    print(characters[5].thumbnailUrl);
    setState(() {
      _characters = characters;
    });
  }

  @override
  void initState() {
    super.initState();
    getCharacters();
  }

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
              _characters.isNotEmpty ? _characters[2].name : 'Loading...',
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
