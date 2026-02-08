import 'package:flutter/material.dart';
import 'app.dart';
import 'platform/window_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initWindow();
  runApp(const MDReaderApp());
}
