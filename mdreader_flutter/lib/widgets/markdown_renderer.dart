import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../theme/markdown_theme.dart';

class MarkdownRenderer extends StatelessWidget {
  final String data;
  final double fontSize;

  const MarkdownRenderer({
    super.key,
    required this.data,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownWidget(
      data: data,
      config: MarkdownTheme.config(context, fontSize),
    );
  }
}
