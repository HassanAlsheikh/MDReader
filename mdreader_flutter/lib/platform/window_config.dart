import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:window_manager/window_manager.dart';

Future<void> initWindow() async {
  if (!(Platform.isMacOS || Platform.isLinux || Platform.isWindows)) return;

  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    size: Size(900, 700),
    minimumSize: Size(400, 400),
    center: true,
    title: 'MDReader',
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}

Future<void> updateWindowTitle(String title) async {
  if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
    await windowManager.setTitle(title);
  }
}
