import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/app/app.dart';
import 'package:marvel_app/discover/discover.dart';
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

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final themeMode =
        context.select((ThemeCubit cubit) => cubit.state.themeMode);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: IndexedStack(
          index: context.select((HomeCubit cubit) => cubit.state.tab.index),
          children: [
            const DiscoverPage(),
            Center(
              child: ElevatedButton(
                onPressed: context.read<ThemeCubit>().toggleTheme,
                child: Text(
                  'Change theme to ${themeMode == ThemeMode.light ? 'dark' : 'light'}',
                ),
              ),
            ),
            const Placeholder(),
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBottomBar(),
    );
  }
}
