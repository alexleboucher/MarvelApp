import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:marvel_app/shared/widgets/multiple_lines_text.dart';

class ComicCard extends StatefulWidget {
  const ComicCard({
    required this.imageUrl,
    required this.title,
    this.margin,
    super.key,
  });

  final String? imageUrl;
  final String title;
  final EdgeInsetsGeometry? margin;

  @override
  State<ComicCard> createState() => _ComicCardState();
}

class _ComicCardState extends State<ComicCard> {
  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.w600,
        );

    return Container(
      margin: widget.margin,
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.shadow,
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: widget.imageUrl != null
                    ? Image.network(
                        widget.imageUrl!,
                        loadingBuilder: (
                          BuildContext context,
                          Widget child,
                          ImageChunkEvent? loadingProgress,
                        ) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                    : Image.asset('assets/images/no_cover.jpg'),
              ),
            ),
          ),
          const Gap(10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: MultipleLinesText(
              widget.title,
              style: titleStyle,
              maxLines: 2,
              minLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
