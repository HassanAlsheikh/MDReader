class MarkdownDocument {
  final String text;
  final String fileName;
  final String? filePath;

  const MarkdownDocument({
    required this.text,
    required this.fileName,
    this.filePath,
  });
}
