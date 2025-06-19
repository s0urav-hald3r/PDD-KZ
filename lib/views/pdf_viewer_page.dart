import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:exam_app/config/colors.dart';
import 'package:exam_app/utils/extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:exam_app/config/icons.dart';
import 'package:exam_app/services/navigator_key.dart';

class PDFViewerPage extends StatefulWidget {
  final String pdfAssetPath;
  final String title;

  const PDFViewerPage({
    super.key,
    required this.pdfAssetPath,
    required this.title,
  });

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  String? localPath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPdfFromAsset();
  }

  Future<void> loadPdfFromAsset() async {
    try {
      final ByteData data = await rootBundle.load(widget.pdfAssetPath);
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = '${tempDir.path}/temp_pdf.pdf';
      final File tempFile = File(tempPath);
      await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);

      setState(() {
        localPath = tempPath;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: Container(
          padding: EdgeInsets.fromLTRB(
              15.w, MediaQuery.of(context).padding.top + 15.h, 25.w, 15.h),
          decoration: BoxDecoration(gradient: containerGradient),
          child: Row(children: [
            InkWell(
              onTap: () {
                NavigatorKey.pop();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 7.5, 0, 7.5),
                child: SvgPicture.asset(backArrowIcon),
              ),
            ),
            const Spacer(),
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: whiteColor,
              ),
            ),
            const Spacer(),
          ]),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : localPath != null
              ? PDFView(
                  filePath: localPath!,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: true,
                  pageFling: true,
                  pageSnap: true,
                  fitPolicy: FitPolicy.BOTH,
                  preventLinkNavigation: false,
                  onError: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $error')),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'Failed to load PDF',
                    style: TextStyle(
                      fontSize: 16.w,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
    );
  }
}
