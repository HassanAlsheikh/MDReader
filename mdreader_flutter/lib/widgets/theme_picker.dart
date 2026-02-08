import 'package:flutter/material.dart';
import '../view_models/display_settings.dart';

class ThemePicker extends StatelessWidget {
  final DisplaySettings settings;

  const ThemePicker({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.palette_outlined),
      tooltip: 'Appearance',
      onSelected: (value) {
        switch (value) {
          case 'system':
            settings.setThemeMode(ThemeMode.system);
          case 'light':
            settings.setThemeMode(ThemeMode.light);
          case 'dark':
            settings.setThemeMode(ThemeMode.dark);
          case 'zoom_in':
            settings.zoomIn();
          case 'zoom_out':
            settings.zoomOut();
          case 'zoom_reset':
            settings.resetZoom();
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(enabled: false, child: Text('Appearance')),
        PopupMenuItem(
          value: 'system',
          child: _menuItem(Icons.brightness_auto, 'System', settings.themeMode == ThemeMode.system),
        ),
        PopupMenuItem(
          value: 'light',
          child: _menuItem(Icons.light_mode, 'Light', settings.themeMode == ThemeMode.light),
        ),
        PopupMenuItem(
          value: 'dark',
          child: _menuItem(Icons.dark_mode, 'Dark', settings.themeMode == ThemeMode.dark),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(enabled: false, child: Text('Text Size')),
        PopupMenuItem(
          value: 'zoom_in',
          child: _menuItem(Icons.zoom_in, 'Increase', false),
        ),
        PopupMenuItem(
          value: 'zoom_out',
          child: _menuItem(Icons.zoom_out, 'Decrease', false),
        ),
        PopupMenuItem(
          value: 'zoom_reset',
          child: _menuItem(Icons.restart_alt, 'Reset', false),
        ),
      ],
    );
  }

  Widget _menuItem(IconData icon, String label, bool selected) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 12),
        Text(label),
        if (selected) ...[
          const Spacer(),
          const Icon(Icons.check, size: 18),
        ],
      ],
    );
  }
}
