import 'package:flutter/material.dart';
import '../models/markdown_document.dart';
import '../view_models/display_settings.dart';
import '../widgets/markdown_renderer.dart';
import '../widgets/theme_picker.dart';
import '../services/file_service.dart';
import '../services/print_service.dart';

class DocumentView extends StatelessWidget {
  final MarkdownDocument document;
  final DisplaySettings settings;
  final void Function(MarkdownDocument document) onDocumentOpened;
  final VoidCallback onClose;

  const DocumentView({
    super.key,
    required this.document,
    required this.settings,
    required this.onDocumentOpened,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(document.fileName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onClose,
          tooltip: 'Close document',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: () => _openFile(context),
            tooltip: 'Open file',
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () => PrintService.printDocument(document),
            tooltip: 'Print',
          ),
          ThemePicker(settings: settings),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: MarkdownRenderer(
          data: document.text,
          fontSize: settings.fontSize,
        ),
      ),
    );
  }

  Future<void> _openFile(BuildContext context) async {
    final doc = await FileService.pickAndReadFile();
    if (doc != null) {
      onDocumentOpened(doc);
    }
  }
}
