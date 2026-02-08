import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../theme/markdown_theme.dart';

// Unicode ranges for RTL scripts
final _rtlRegex = RegExp(
  '[\u0590-\u05FF'   // Hebrew
  '\u0600-\u06FF'    // Arabic
  '\u0700-\u074F'    // Syriac
  '\u0780-\u07BF'    // Thaana
  '\u0840-\u085F'    // Mandaic
  '\u08A0-\u08FF'    // Arabic Extended-A
  '\uFB50-\uFDFF'    // Arabic Presentation Forms-A
  '\uFE70-\uFEFF'    // Arabic Presentation Forms-B
  ']',
);

bool _isRtlText(String text) {
  // Sample the first ~500 non-markup characters to determine direction.
  // Strip common markdown syntax so we're checking prose, not markers.
  final stripped = text
      .replaceAll(RegExp(r'[#*_`\[\]()!>|~\-=+]'), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  final sample = stripped.length > 500 ? stripped.substring(0, 500) : stripped;
  if (sample.isEmpty) return false;

  final rtlCount = _rtlRegex.allMatches(sample).length;
  final latinCount = RegExp(r'[A-Za-z]').allMatches(sample).length;
  return rtlCount > latinCount;
}

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
    final direction = _isRtlText(data) ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: direction,
      child: MarkdownWidget(
        data: data,
        config: MarkdownTheme.config(context, fontSize),
      ),
    );
  }
}
