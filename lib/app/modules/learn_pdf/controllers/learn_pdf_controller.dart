import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class LearnPdfController extends GetxController {
  var products = List.generate(30, (index) {
    return {
      'id': '${index + 1}',
      'name': 'name ${index + 1}',
      'date': DateTime.now()
    };
  });
  void getPdf() async {
    final img = 'assets/images/woman.png';
    final imageData = await rootBundle.load(img);
    final image = pw.MemoryImage(imageData.buffer.asUint8List());

    final fontData = await rootBundle.load('assets/fonts/OpenSans_Regular.ttf');
    final ttf = pw.Font.ttf(fontData);

    print('PDF');
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
              pw.Text('JUDUL',
                  style: pw.TextStyle(
                      fontBold: pw.Font.timesBold(), font: ttf, fontSize: 40)),
            ]),
            pw.SizedBox(height: 20),
            pw.Column(
                children: products
                    .map((e) =>
                        pw.Table(border: pw.TableBorder.all(), children: [
                          pw.TableRow(children: [
                            pw.Row(children: [
                              pw.Text('${e['id']}. ',
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 20,
                                      fontBold: pw.Font.courierBold())),
                              pw.SizedBox(width: 20),
                              pw.Text('${e['name']}. ',
                                  style: pw.TextStyle(
                                      font: ttf,
                                      fontSize: 20,
                                      fontBold: pw.Font.courierBold())),
                              pw.SizedBox(width: 50),
                              pw.Text('${e['date']}. ',
                                  style: pw.TextStyle(font: ttf)),
                            ])
                          ])
                        ]))
                    .toList())
            ////pw.Center(child: pw.Table(border: pw.TableBorder.all(),children: [pw.TableRow(children: [])]))
            // pw.Center(
            //     child: pw.Table(border: pw.TableBorder.all(), children: [
            //   pw.TableRow(children: [
            //     pw.Text('Maa',
            //         style: pw.TextStyle(
            //             letterSpacing: 2,
            //             font: ttf,
            //             fontSize: 12,
            //             fontWeight: pw.FontWeight.bold)),
            //     pw.Text('PAAAA',
            //         style: pw.TextStyle(
            //             font: ttf,
            //             fontSize: 12,
            //             fontWeight: pw.FontWeight.bold))
            //   ]),
            //   pw.TableRow(children: [
            //     pw.Text('PAAAA',
            //         style: pw.TextStyle(
            //             font: ttf,
            //             fontSize: 12,
            //             fontWeight: pw.FontWeight.bold)),
            //     pw.Text('PAAAA',
            //         style: pw.TextStyle(
            //             font: ttf,
            //             fontSize: 12,
            //             fontWeight: pw.FontWeight.bold))
            //   ])
            // ]))
            ////////////////////////////////////////////////
            // pw.ListView(
            //     children: products
            //         .map(
            //           (e) => pw.Container(
            //               color: PdfColors.amber,
            //               child: pw.Column(children: [
            //                 pw.Row(children: [
            //                   pw.Container(
            //                       height: 20,
            //                       width: 20,
            //                       child: pw.Image(image)),
            //                   pw.SizedBox(width: 20),
            //                   pw.Text('${e['name']}',
            //                       style: pw.TextStyle(font: ttf, fontSize: 20))
            //                 ]),
            //                 pw.Text('${e['date']}')
            //               ])),
            //         )
            //         .toList())
          ];
        })); // Page
    Uint8List bytes = await pdf.save();
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/mydoc.pdf');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }
}
