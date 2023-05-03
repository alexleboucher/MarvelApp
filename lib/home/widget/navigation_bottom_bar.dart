import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel_app/home/home.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) => context.read<HomeCubit>().setTab(HomeTab.values[index]),
      currentIndex: selectedTab.index,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.explore_outlined),
          activeIcon: const Icon(Icons.explore),
          label: AppLocalizations.of(context)!.explore,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.search),
          activeIcon: const Icon(Icons.search),
          label: AppLocalizations.of(context)!.search,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_border),
          activeIcon: const Icon(Icons.favorite),
          label: AppLocalizations.of(context)!.favorites,
        ),
      ],
    );
  }
}
