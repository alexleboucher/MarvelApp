import 'package:flutter/material.dart';

class MultipleLinesText extends StatelessWidget {
  const MultipleLinesText(
    this.text, {
    super.key,
    this.maxLines,
    this.minLines,
    this.style,
    this.overflow = TextOverflow.ellipsis,
  });

  final String text;
  final int? maxLines;
  final int? minLines;
  final TextStyle? style;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    final buffer = StringBuffer(text);
    if (minLines != null) {
      for (var i = 0; i < minLines!; i++) {
        buffer.write('\n');
      }
    }
    return Text(
      buffer.toString(),
      style: style,
      maxLines: maxLines ?? minLines,
      overflow: overflow,
    );
  }
}
