import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/discover/discover.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: IndexedStack(
          index: context.select((HomeCubit cubit) => cubit.state.tab.index),
          children: const [
            DiscoverPage(),
            Placeholder(),
            Placeholder(),
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBottomBar(),
    );
  }
}
