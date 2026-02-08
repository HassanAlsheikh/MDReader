import 'dart:io';
import 'package:file_picker/file_picker.dart';
import '../models/markdown_document.dart';

class FileService {
  static Future<MarkdownDocument?> pickAndReadFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['md', 'markdown', 'mdown', 'mkd', 'mkdn', 'txt'],
    );

    if (result == null || result.files.isEmpty) return null;

    final file = result.files.single;
    final path = file.path;
    if (path == null) return null;

    return readFile(path);
  }

  static Future<MarkdownDocument> readFile(String path) async {
    final file = File(path);
    final text = await file.readAsString();
    final fileName = file.uri.pathSegments.last;
    return MarkdownDocument(text: text, fileName: fileName, filePath: path);
  }
}
