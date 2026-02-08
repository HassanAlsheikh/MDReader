import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/markdown_document.dart';

class PrintService {
  static Future<void> printDocument(MarkdownDocument document) async {
    await Printing.layoutPdf(
      name: document.fileName,
      onLayout: (PdfPageFormat format) async {
        final pdf = pw.Document();
        final lines = document.text.split('\n');

        pdf.addPage(
          pw.MultiPage(
            pageFormat: format,
            margin: const pw.EdgeInsets.all(40),
            header: (context) => pw.Text(
              document.fileName,
              style: pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey600,
              ),
            ),
            build: (context) => lines.map((line) {
              // Basic heading detection for print
              if (line.startsWith('# ')) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 12, bottom: 4),
                  child: pw.Text(
                    line.substring(2),
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                );
              } else if (line.startsWith('## ')) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 10, bottom: 3),
                  child: pw.Text(
                    line.substring(3),
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                );
              } else if (line.startsWith('### ')) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 8, bottom: 2),
                  child: pw.Text(
                    line.substring(4),
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                );
              } else if (line.trim().isEmpty) {
                return pw.SizedBox(height: 8);
              } else {
                return pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 2),
                  child: pw.Text(
                    line,
                    style: const pw.TextStyle(fontSize: 12),
                  ),
                );
              }
            }).toList(),
          ),
        );

        return pdf.save();
      },
    );
  }
}
