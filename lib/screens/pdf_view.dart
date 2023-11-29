import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdfView extends StatefulWidget {
  final String title;
  final String source;
  const pdfView({
    super.key,
    required this.title,
    required this.source,
  });

  @override
  State<pdfView> createState() => _pdfViewState();
}

class _pdfViewState extends State<pdfView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontFamily: 'geb'),
        ),
      ),
      body: SfPdfViewer.network(
        widget.source,
        key: _pdfViewerKey,
      ),
    );
  }
}
