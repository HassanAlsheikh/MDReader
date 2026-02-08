import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/markdown_document.dart';
import 'view_models/display_settings.dart';
import 'views/home_view.dart';
import 'views/document_view.dart';
import 'services/file_service.dart';
import 'platform/desktop_menu.dart';
import 'platform/keyboard_shortcuts.dart';
import 'platform/window_config.dart';
import 'theme/app_theme.dart';

class MDReaderApp extends StatefulWidget {
  final SharedPreferences prefs;

  const MDReaderApp({super.key, required this.prefs});

  @override
  State<MDReaderApp> createState() => _MDReaderAppState();
}

class _MDReaderAppState extends State<MDReaderApp> {
  late final _settings = DisplaySettings(widget.prefs);
  MarkdownDocument? _document;

  static const _openFileChannel = MethodChannel('com.hassanalsheikh.mdreader/open_file');

  @override
  void initState() {
    super.initState();
    // Handle warm-start file opens (app already running)
    _openFileChannel.setMethodCallHandler(_handleMethodCall);
    // Handle cold-start file opens (app launched by opening a file)
    _checkPendingFile();
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    if (call.method == 'openFile') {
      final path = call.arguments as String;
      await _openFileFromPath(path);
    }
  }

  Future<void> _checkPendingFile() async {
    try {
      final path = await _openFileChannel.invokeMethod<String>('getPendingFile');
      if (path != null) {
        await _openFileFromPath(path);
      }
    } catch (_) {
      // Channel not available on non-macOS platforms
    }
  }

  Future<void> _openFileFromPath(String path) async {
    try {
      final document = await FileService.readFile(path);
      _openDocument(document);
    } catch (e) {
      debugPrint('Failed to open file: $e');
    }
  }

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
