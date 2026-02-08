import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../view_models/display_settings.dart';
import '../models/markdown_document.dart';
import '../services/file_service.dart';
import '../services/print_service.dart';

class DesktopMenuBar extends StatelessWidget {
  final Widget child;
  final DisplaySettings settings;
  final MarkdownDocument? currentDocument;
  final void Function(MarkdownDocument) onDocumentOpened;

  const DesktopMenuBar({
    super.key,
    required this.child,
    required this.settings,
    required this.currentDocument,
    required this.onDocumentOpened,
  });

  @override
  Widget build(BuildContext context) {
    if (!Platform.isMacOS) return child;

    return PlatformMenuBar(
      menus: [
        PlatformMenu(
          label: 'MDReader',
          menus: [
            PlatformMenuItem(
              label: 'About MDReader',
              onSelected: () => _showAbout(context),
            ),
            const PlatformProvidedMenuItem(type: PlatformProvidedMenuItemType.quit),
          ],
        ),
        PlatformMenu(
          label: 'File',
          menus: [
            PlatformMenuItem(
              label: 'Open...',
              shortcut: const SingleActivator(LogicalKeyboardKey.keyO, meta: true),
              onSelected: () async {
                final doc = await FileService.pickAndReadFile();
                if (doc != null) onDocumentOpened(doc);
              },
            ),
            if (currentDocument != null)
              PlatformMenuItem(
                label: 'Print...',
                shortcut: const SingleActivator(LogicalKeyboardKey.keyP, meta: true),
                onSelected: () {
                  if (currentDocument != null) {
                    PrintService.printDocument(currentDocument!);
                  }
                },
              ),
          ],
        ),
        PlatformMenu(
          label: 'View',
          menus: [
            PlatformMenuItem(
              label: 'Zoom In',
              shortcut: const SingleActivator(LogicalKeyboardKey.equal, meta: true),
              onSelected: settings.zoomIn,
            ),
            PlatformMenuItem(
              label: 'Zoom Out',
              shortcut: const SingleActivator(LogicalKeyboardKey.minus, meta: true),
              onSelected: settings.zoomOut,
            ),
            PlatformMenuItem(
              label: 'Actual Size',
              shortcut: const SingleActivator(LogicalKeyboardKey.digit0, meta: true),
              onSelected: settings.resetZoom,
            ),
          ],
        ),
      ],
      child: child,
    );
  }

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'MDReader',
      applicationVersion: '2.0.3',
      applicationIcon: const Icon(Icons.description_outlined, size: 48),
      children: [
        const SizedBox(height: 8),
        const Text('A cross-platform read-only markdown viewer.'),
        const SizedBox(height: 16),
        const Text(
          'Hassan Alsheikh asked Claude to code this idea.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
