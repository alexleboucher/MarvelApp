import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:marvel_app/app/cubit/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.select((SettingsCubit cubit) => cubit.state);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.beamBack(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.darkTheme,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch(
                      value: settings.themeMode == ThemeMode.dark,
                      onChanged: (_) =>
                          context.read<SettingsCubit>().toggleTheme(),
                    )
                  ],
                ),
                const Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    DropdownButton<String>(
                      value: settings.locale.languageCode,
                      onChanged: (String? value) =>
                          context.read<SettingsCubit>().changeLocale(value!),
                      items: const [
                        DropdownMenuItem<String>(
                          value: 'en',
                          child: Text('English'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'fr',
                          child: Text('Français'),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
