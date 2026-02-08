import 'package:flutter/material.dart';
import '../services/file_service.dart';
import '../models/markdown_document.dart';

class HomeView extends StatelessWidget {
  final void Function(MarkdownDocument document) onDocumentOpened;

  const HomeView({super.key, required this.onDocumentOpened});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.description_outlined,
            size: 80,
            color: isDark ? Colors.white24 : Colors.black26,
          ),
          const SizedBox(height: 24),
          Text(
            'MDReader',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: isDark ? Colors.white54 : Colors.black54,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'A cross-platform markdown viewer',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isDark ? Colors.white38 : Colors.black38,
                ),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: () => _openFile(context),
            icon: const Icon(Icons.folder_open),
            label: const Text('Open Markdown File'),
          ),
        ],
      ),
    );
  }

  Future<void> _openFile(BuildContext context) async {
    final document = await FileService.pickAndReadFile();
    if (document != null) {
      onDocumentOpened(document);
    }
  }
}
