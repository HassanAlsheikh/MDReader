import 'dart:io';
import 'package:flutter/material.dart';
import 'models/markdown_document.dart';
import 'view_models/display_settings.dart';
import 'views/home_view.dart';
import 'views/document_view.dart';
import 'platform/desktop_menu.dart';
import 'platform/keyboard_shortcuts.dart';
import 'platform/window_config.dart';
import 'theme/app_theme.dart';

class MDReaderApp extends StatefulWidget {
  const MDReaderApp({super.key});

  @override
  State<MDReaderApp> createState() => _MDReaderAppState();
}

class _MDReaderAppState extends State<MDReaderApp> {
  final _settings = DisplaySettings();
  MarkdownDocument? _document;

  void _openDocument(MarkdownDocument document) {
    setState(() => _document = document);
    updateWindowTitle('MDReader — ${document.fileName}');
  }

  void _closeDocument() {
    setState(() => _document = null);
    updateWindowTitle('MDReader');
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _settings,
      builder: (context, _) {
        return MaterialApp(
          title: 'MDReader',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: _settings.themeMode,
          home: _buildShell(),
        );
      },
    );
  }

  Widget _buildShell() {
    final isDesktop = Platform.isMacOS || Platform.isLinux || Platform.isWindows;

    Widget body;
    if (_document != null) {
      body = DocumentView(
        document: _document!,
        settings: _settings,
        onDocumentOpened: _openDocument,
        onClose: _closeDocument,
      );
    } else {
      body = Scaffold(
        appBar: AppBar(
          title: const Text('MDReader'),
        ),
        body: HomeView(onDocumentOpened: _openDocument),
      );
    }

    if (isDesktop) {
      body = DesktopMenuBar(
        settings: _settings,
        currentDocument: _document,
        onDocumentOpened: _openDocument,
        child: body,
      );
    }

    return Shortcuts(
      shortcuts: appShortcuts,
      child: Actions(
        actions: appActions(
          settings: _settings,
          currentDocument: _document,
          onDocumentOpened: _openDocument,
        ),
        child: Focus(
          autofocus: true,
          child: body,
        ),
      ),
    );
  }
}
