import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplaySettings extends ChangeNotifier {
  static const double _defaultFontSize = 16.0;
  static const double _minFontSize = 10.0;
  static const double _maxFontSize = 32.0;
  static const double _fontSizeStep = 2.0;

  final SharedPreferences _prefs;

  double _fontSize;
  ThemeMode _themeMode;

  double get fontSize => _fontSize;
  ThemeMode get themeMode => _themeMode;

  DisplaySettings(SharedPreferences prefs)
      : _prefs = prefs,
        _fontSize = prefs.getDouble('fontSize') ?? _defaultFontSize,
        _themeMode = ThemeMode.values[
            prefs.getInt('themeMode') ?? ThemeMode.system.index];

  Future<void> _save() async {
    await _prefs.setDouble('fontSize', _fontSize);
    await _prefs.setInt('themeMode', _themeMode.index);
  }

  void zoomIn() {
    if (_fontSize < _maxFontSize) {
      _fontSize += _fontSizeStep;
      notifyListeners();
      _save();
    }
  }

  void zoomOut() {
    if (_fontSize > _minFontSize) {
      _fontSize -= _fontSizeStep;
      notifyListeners();
      _save();
    }
  }

  void resetZoom() {
    _fontSize = _defaultFontSize;
    notifyListeners();
    _save();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    _save();
  }
}
