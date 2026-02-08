import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'platform/window_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Run window init and prefs loading concurrently instead of sequentially.
  final windowInit = initWindow();
  final prefsInit = SharedPreferences.getInstance();
  await windowInit;

  runApp(MDReaderApp(prefs: await prefsInit));
}
