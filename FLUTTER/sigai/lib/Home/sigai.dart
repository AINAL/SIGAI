


import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';

Future<void> openPDFfromAssets(BuildContext context) async {
  try {
    final byteData = await rootBundle.load('assets/SIGAI.pdf');
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/SIGAI.pdf');
    await file.writeAsBytes(byteData.buffer.asUint8List());

    final result = await OpenFile.open(file.path);
    if (result.type != ResultType.done) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to open PDF')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error opening PDF: $e')),
    );
  }
}