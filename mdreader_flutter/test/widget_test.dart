import 'package:flutter_test/flutter_test.dart';
import 'package:mdreader/models/markdown_document.dart';

void main() {
  test('MarkdownDocument holds text and filename', () {
    const doc = MarkdownDocument(
      text: '# Hello',
      fileName: 'test.md',
      filePath: '/tmp/test.md',
    );
    expect(doc.text, '# Hello');
    expect(doc.fileName, 'test.md');
    expect(doc.filePath, '/tmp/test.md');
  });
}
