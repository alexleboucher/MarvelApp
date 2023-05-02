import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_app/discover/discover.dart';
import 'package:marvel_app/favorites/view/favorites_page.dart';
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
    final curentTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: IndexedStack(
          index: curentTab.index,
          children: const [
            DiscoverPage(),
            Placeholder(),
            FavoritesPage(),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        toolbarHeight: 50,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.beamToNamed('/settings'),
          ),
        ],
      ),
      bottomNavigationBar: const NavigationBottomBar(),
    );
  }
}
