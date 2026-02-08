import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownTheme {
  static MarkdownConfig config(BuildContext context, double fontSize) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white.withValues(alpha: 0.87) : Colors.black87;
    final codeBackground = isDark ? const Color(0xFF2D2D2D) : const Color(0xFFF6F8FA);
    final blockquoteBorder = isDark ? Colors.white24 : Colors.black26;

    return MarkdownConfig(configs: [
      PConfig(textStyle: TextStyle(fontSize: fontSize, color: textColor, height: 1.6)),
      H1Config(style: TextStyle(fontSize: fontSize * 2, fontWeight: FontWeight.bold, color: textColor)),
      H2Config(style: TextStyle(fontSize: fontSize * 1.5, fontWeight: FontWeight.bold, color: textColor)),
      H3Config(style: TextStyle(fontSize: fontSize * 1.25, fontWeight: FontWeight.bold, color: textColor)),
      H4Config(style: TextStyle(fontSize: fontSize * 1.1, fontWeight: FontWeight.bold, color: textColor)),
      H5Config(style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: textColor)),
      H6Config(style: TextStyle(fontSize: fontSize * 0.85, fontWeight: FontWeight.bold, color: textColor)),
      PreConfig(
        decoration: BoxDecoration(
          color: codeBackground,
          borderRadius: BorderRadius.circular(6),
        ),
        textStyle: TextStyle(fontSize: fontSize * 0.85),
        padding: const EdgeInsets.all(16),
      ),
      CodeConfig(
        style: TextStyle(
          fontSize: fontSize * 0.85,
          backgroundColor: codeBackground,
          fontFamily: 'monospace',
          color: textColor,
        ),
      ),
      BlockquoteConfig(
        sideColor: blockquoteBorder,
        textColor: textColor.withValues(alpha: 0.7),
      ),
      LinkConfig(
        style: TextStyle(
          fontSize: fontSize,
          color: isDark ? Colors.lightBlueAccent : Colors.blue,
          decoration: TextDecoration.underline,
        ),
        onTap: (url) {
          final uri = Uri.tryParse(url);
          if (uri != null) {
            launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
      ),
      TableConfig(
        headerStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize, color: textColor),
        bodyStyle: TextStyle(fontSize: fontSize, color: textColor),
      ),
      HrConfig(color: isDark ? Colors.white24 : Colors.black12),
      ListConfig(
        marker: (isOrdered, depth, index) {
          final text = isOrdered ? '${index + 1}.' : '•';
          return Text(text, style: TextStyle(fontSize: fontSize, color: textColor));
        },
      ),
      ImgConfig(),
    ]);
  }
}
