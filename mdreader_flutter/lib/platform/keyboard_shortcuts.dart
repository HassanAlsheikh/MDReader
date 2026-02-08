import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../view_models/display_settings.dart';
import '../services/file_service.dart';
import '../services/print_service.dart';
import '../models/markdown_document.dart';

// Intents
class ZoomInIntent extends Intent {
  const ZoomInIntent();
}

class ZoomOutIntent extends Intent {
  const ZoomOutIntent();
}

class ResetZoomIntent extends Intent {
  const ResetZoomIntent();
}

class OpenFileIntent extends Intent {
  const OpenFileIntent();
}

class PrintIntent extends Intent {
  const PrintIntent();
}

Map<ShortcutActivator, Intent> get appShortcuts => {
      LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.equal): const ZoomInIntent(),
      LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.add): const ZoomInIntent(),
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.equal): const ZoomInIntent(),
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.add): const ZoomInIntent(),
      LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.minus): const ZoomOutIntent(),
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.minus): const ZoomOutIntent(),
      LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.digit0): const ResetZoomIntent(),
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.digit0): const ResetZoomIntent(),
      LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyO): const OpenFileIntent(),
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyO): const OpenFileIntent(),
      LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyP): const PrintIntent(),
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyP): const PrintIntent(),
    };

Map<Type, Action<Intent>> appActions({
  required DisplaySettings settings,
  required MarkdownDocument? currentDocument,
  required void Function(MarkdownDocument) onDocumentOpened,
}) =>
    {
      ZoomInIntent: CallbackAction<ZoomInIntent>(
        onInvoke: (_) {
          settings.zoomIn();
          return null;
        },
      ),
      ZoomOutIntent: CallbackAction<ZoomOutIntent>(
        onInvoke: (_) {
          settings.zoomOut();
          return null;
        },
      ),
      ResetZoomIntent: CallbackAction<ResetZoomIntent>(
        onInvoke: (_) {
          settings.resetZoom();
          return null;
        },
      ),
      OpenFileIntent: CallbackAction<OpenFileIntent>(
        onInvoke: (_) {
          FileService.pickAndReadFile().then((doc) {
            if (doc != null) onDocumentOpened(doc);
          });
          return null;
        },
      ),
      PrintIntent: CallbackAction<PrintIntent>(
        onInvoke: (_) {
          if (currentDocument != null) {
            PrintService.printDocument(currentDocument);
          }
          return null;
        },
      ),
    };
