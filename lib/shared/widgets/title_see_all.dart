import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TitleSeeAll extends StatelessWidget {
  const TitleSeeAll({
    required this.title,
    required this.onSeeAllClick,
    super.key,
  });

  final String title;
  final VoidCallback onSeeAllClick;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(fontWeight: FontWeight.bold);
    final seeAllStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        TextButton(
          onPressed: onSeeAllClick,
          child: Text(
            AppLocalizations.of(context)!.seeAll,
            style: seeAllStyle,
          ),
        ),
      ],
    );
  }
}
