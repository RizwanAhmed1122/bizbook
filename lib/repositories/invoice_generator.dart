import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class InvoiceGenerator {
  static Future<String> generatePdf({required String customerName, required List<Map<String, dynamic>> items, required double discount, required double total}) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('BizBook Invoice', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 12),
            pw.Text('Customer: $customerName'),
            pw.SizedBox(height: 8),
            pw.Divider(),
            pw.SizedBox(height: 8),
            ...items.map((item) => pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(item['name'] as String),
                    pw.Text('${item['quantity']} x ${item['price']}'),
                  ],
                )).toList(),
            pw.SizedBox(height: 12),
            pw.Text('Discount: $discount%'),
            pw.Text('Total: PKR ${total.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/invoice.pdf');
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }

  static Future<void> shareInvoice(String path) async {
    await Share.shareXFiles([XFile(path)]);
  }
}
