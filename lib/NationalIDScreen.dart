import 'dart:io';
//import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:pdf/pdf.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class NationalIDScreen extends StatefulWidget {
  const NationalIDScreen({super.key});

  @override
  State<NationalIDScreen> createState() => _NationalIDScreenState();
}

class _NationalIDScreenState extends State<NationalIDScreen> {
  // مفتاح لالتقاط صورة للورقة (RepaintBoundary)
  final GlobalKey _paperKey = GlobalKey();

  // بيانات وهمية كما في الصورة — عدّلها إن أحببت
  final Map<String, String> leftData = {
    'الرقم/IN Number': '1082319755',
    'الاسم بالانجليزي/Name': 'IBRAHIM, RAED MUHAMMED I',
    'تاريخ الميلاد/Date Of Birth': '17/04/1992',
    'تاريخ الاصدار/Date Issue': '14/07/2017',
    'تاريخ الانتهاء بالهجري/Expire Date in Hijri': '1450/09/18هـ',
    '': '',
  };

  final Map<String, String> rightData = {
    'الاسم/Name in Arsbic': 'رائد بن محمد بن إبراهيم إبراهيم',
    'مكان الميلاد/Place Of Pirrh': 'جده',
    'تاريخ الميلاد بالهجري/Date of': '1412/10/14هـ',
    'رقم الهوية بالانجليزي/ID Number io': '1082319755',
    'تاريخ الانتهاء/Expire Date': '02/02/2029',
    'نسخة/Copy': '5',
    //'': '',
  };

  // فتح الـ Bottom Sheet (قابلة للسحب) التي تعرض الورقة
  /*void _openShareSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.78,
          minChildSize: 0.5,
          maxChildSize: 0.98,
          expand: false,  // ⚠️ مهم جدًا حتى لا ينهار
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // الشريط العلوي
                  Container(
                    width: 60,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  // زر المشاركة
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        IconButton(
                          tooltip: 'مشاركة كملف PDF',
                          icon: const Icon(Icons.share_outlined, size: 28),
                          onPressed: () async {
                            await _captureAndSharePdf();
                          },
                        ),
                      ],
                    ),
                  ),

                  // المحتوى — يجب أن يكون داخل Expanded + Scroll
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8,
                        ),
                        child: Center(
                          child: RepaintBoundary(
                            key: _paperKey,
                            child: _buildA4Paper(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }*/

  void _openShareSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.78,
          minChildSize: 0.5,
          maxChildSize: 0.98,
          expand: true,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 60,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  // عنوان + زر مشاركة
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child:
                              SizedBox(), // يترك المساحة ليتوسط الزرين على اليمين
                        ),
                        IconButton(
                          tooltip: 'مشاركة كملف PDF',
                          icon: const Icon(Icons.share_outlined, size: 28),
                          onPressed: () async {
                            await _captureAndSharePdf();
                          },
                        ),
                      ],
                    ),
                  ),

                  /*Flexible(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                        child: Center(
                          child: RepaintBoundary(
                            key: _paperKey,
                            child: _buildA4Paper(),
                          ),
                        ),
                      ),
                    ),
                  ),*/
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 8,
                          ),
                          child: RepaintBoundary(
                            key: _paperKey,
                            //child: _buildA4Paper(),
                            child: _buildPaperView(), // هذا هو التصميم المطابق
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // التقاط الـ Widget كصورة، ثم إنشاء PDF ومشاركة الملف
  Future<void> _captureAndSharePdf() async {
    try {
      final now = DateTime.now();

      final datePart =
          '${now.year.toString().padLeft(4, '0')}-'
          '${now.month.toString().padLeft(2, '0')}-'
          '${now.day.toString().padLeft(2, '0')}';

      final String fileName = 'الهوية_$datePart.pdf';

      // قراءة ملف PDF من assets
      final byteData = await rootBundle.load('assets/1.pdf');

      final bytes = byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      );

      // حفظ الملف المؤقت
      final tempDir = await getTemporaryDirectory();

      final file = File('${tempDir.path}/$fileName');

      await file.writeAsBytes(bytes, flush: true);

      // مشاركة الملف
      await Share.shareXFiles([
        XFile(file.path, mimeType: 'application/pdf'),
      ], text: fileName);
    } catch (e, st) {
      debugPrint('Error exporting PDF: $e\n$st');

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ أثناء التصدير: $e')));
    }
  }
  /*Future<void> _captureAndSharePdf() async {
    try {
      final boundary =
          _paperKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;

      if (boundary == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لم أجد الورقة لالتقاطها')),
        );
        return;
      }

      // 👇 مهم جداً — يجعل الكود يعمل على Web بدون الخطأ المعروف
      final double ratio = kIsWeb ? 1.0 : 3.0;

      final ui.Image image = await boundary.toImage(pixelRatio: ratio);

      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل تحويل الصورة إلى بايت')),
        );
        return;
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      // ⬇ إنشاء PDF
      final pdfDoc = pw.Document();
      final pwImage = pw.MemoryImage(pngBytes);

      pdfDoc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.zero, // لا هوامش
          build: (ctx) {
            // استخدم عرض/ارتفاع الصفحة كحد أقصى للصورة
            final pageWidth = PdfPageFormat.a4.width;
            final pageHeight = PdfPageFormat.a4.height;

            return pw.Center(
              child: pw.Container(
                width: pageWidth,
                height: pageHeight,
                alignment: pw.Alignment.center,
                child: pw.Image(
                  pwImage,
                  fit: pw.BoxFit.fill, // ❗ لا قص ولا تمدد، ويحافظ على النسبة
                  width: pageWidth, // نجبر الصورة على أكبر مساحة ممكنة
                  height: pageHeight,
                  alignment: pw.Alignment.center,
                ),
              ),
            );
          },
        ),
      );

      /*pdfDoc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.zero, // إلغاء الهوامش
          build: (ctx) {
            return pw.Container(
              width: double.infinity,
              height: double.infinity,
              child: pw.Image(
                pwImage,
                fit: pw.BoxFit.contain, // الصورة تملأ الصفحة بالكامل
                width: pageWidth,           // نجبر الصورة على أكبر مساحة ممكنة
                height: pageHeight,
                alignment: pw.Alignment.center,
              ),
            );
          },
        ),
      );*/
      /*pdfDoc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (ctx) {
            return pw.Center(
              child: pw.Image(
                pwImage,
                fit: pw.BoxFit.cover,
              ),
            );
          },
        ),
      );*/

      // ⬇ حفظ ملف مؤقت
      final tempDir = await getTemporaryDirectory();
      final file = File(
        '${tempDir.path}/national_id_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );

      await file.writeAsBytes(await pdfDoc.save());

      // ⬇ مشاركة
      await Share.shareXFiles([
        XFile(file.path, mimeType: 'application/pdf'),
      ], text: 'الهوية الوطنية (PDF)');
    } catch (e, st) {
      debugPrint('Error capture/share PDF: $e\n$st');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ أثناء المشاركة: $e')));
    }
  }*/

  /*Future<void> _captureAndSharePdf() async {
    try {
      // 1) التقاط الصورة من الـ RepaintBoundary
      final boundary = _paperKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('لم أجد الورقة لالتقاطها')));
        return;
      }

      // يمكن زيادة pixelRatio للحصول على دقة أعلى في الـ PDF
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('فشل تحويل الصورة إلى بايت')));
        return;
      }
      final Uint8List pngBytes = byteData.buffer.asUint8List();

      // 2) إنشاء ملف PDF بواسطة مكتبة pdf ووضع الصورة داخل صفحة A4
      final pdfDoc = pw.Document();
      final pwImage = pw.MemoryImage(pngBytes);

      pdfDoc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context ctx) {
            return pw.Center(
              child: pw.Image(
                pwImage,
                fit: pw.BoxFit.contain,
              ),
            );
          },
        ),
      );

      // 3) حفظ PDF في مجلد مؤقت
      final tempDir = await getTemporaryDirectory();
      final file = File(
          '${tempDir.path}/national_id_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await pdfDoc.save());

      // 4) مشاركة الملف (استخدم shareXFiles)
      await Share.shareXFiles([XFile(file.path, mimeType: 'application/pdf')],
          text: 'الهوية الوطنية (PDF)');
    } catch (e, st) {
      debugPrint('Error capture/share PDF: $e\n$st');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('حدث خطأ أثناء المشاركة: $e')));
    }
  }*/
  Widget _buildA4Paper() {
    const double ratio = 3.0; // دقة عالية للطباعة

    // أبعاد A4 بالنقاط × نسبة الجودة
    final double width = 595 * ratio;
    final double height = 842 * ratio;

    return Center(
      child: RepaintBoundary(
        key: _paperKey,
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
          child: _buildPaperContent(), // محتوى البطاقة بالكامل
        ),
      ),
    );
  }

  Widget _buildPaperContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 12),

        // ===== HEADER =====
        Container(
          height: 82,
          padding: EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/vz222.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),

        SizedBox(height: 10),

        // ===== NATIONAL ID CARD IMAGE =====
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset("assets/022.png", fit: BoxFit.cover),
          ),
        ),

        SizedBox(height: 10),

        // ===== INFO BOX =====
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              color: Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: rightData.entries.map((e) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(e.key, style: TextStyle(fontSize: 8)),
                            SizedBox(height: 1),
                            Text(e.value, style: TextStyle(fontSize: 9)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 1),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: leftData.entries.map((e) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(e.key, style: TextStyle(fontSize: 8)),
                            SizedBox(height: 1),
                            Text(e.value, style: TextStyle(fontSize: 9)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 35),

        // ===== FOOTER =====
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Image.asset("assets/qr.png", width: 60, height: 60),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "تم مشاركة هذه الوثيقة من خلال توكلنا",
                      style: TextStyle(fontSize: 11),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "This document is shared through",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text("Tawakkalna", style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 50),
      ],
    );
  }

  // هذا الويجت يبني "الورقة" بنفس شكل الصورة قدر الإمكان
  Widget _buildPaperView() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 15),

          // =================== HEADER ===================
          Container(
            height: 82,
            //color: const Color(0xFF2B2B2B),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              // لو كنت تريد لون خلفية احتياطي يمكن وضعه هنا:
              //color: const Color(0xFF2B2B2B),
              image: const DecorationImage(
                image: AssetImage('assets/vz222.png'), // اسم ملف الصورة الخلفية
                fit: BoxFit
                    .fill, // أو BoxFit.fill / BoxFit.fitWidth حسب الشكل المطلوب
              ),
            ),
            /*child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // نص الهوية
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "الهوية الوطنية",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "National IN",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),

              // الشعارات
              Row(
                children: [
                  Image.asset("assets/header_icons.png", height: 36), 
                  const SizedBox(width: 14),
                  Image.asset("assets/tw_logo.png", height: 36),
                ],
              )
            ],
          ),*/
          ),

          const SizedBox(height: 15),

          // =================== NATIONAL ID CARD IMAGE ===================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/022.png",
                fit: BoxFit.fill,
                height: 200,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // =================== INFO BOX ===================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 08),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // العمود العربي
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: rightData.entries.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                e.key,
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                e.value,
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  // العمود الإنجليزي
                  const SizedBox(width: 1),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: leftData.entries.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                e.key,
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                e.value,
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  //const SizedBox(width: 10),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),

          // =================== FOOTER ===================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/qr.png", width: 60, height: 60),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "تم مشاركة هذه الوثيقة من خلال توكلنا",
                        style: TextStyle(fontSize: 11),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "This document is shared through",
                        style: TextStyle(fontSize: 10, color: Colors.black54),
                      ),
                      Text(
                        "Tawakkalna",
                        style: TextStyle(fontSize: 10, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                //Image.asset("assets/qr.png", width: 90, height: 90),
              ],
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  // صف واحد من بيانات info (عنوان + قيمة)
  Widget _infoRow(String title, String value, {bool alignRight = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: alignRight
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.black54, fontSize: 13)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateNow =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    final timeNow =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'الهوية الوطنية',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GestureDetector(
                onTap: () => Navigator.of(context).maybePop(),
                child: const Icon(Icons.close, color: Colors.white, size: 30),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),

              // ===== بطاقة الهوية المصغرة المعروضة في الشاشة (ليست الورقة الكاملة) =====
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  //child: //Image.asset('assets/023.png', fit: BoxFit.cover),
                  child: GestureDetector(
                    onTap: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: '',
                        barrierColor: Colors.black.withOpacity(0.90),
                        transitionDuration: const Duration(milliseconds: 350),
                        pageBuilder: (_, __, ___) {
                          return const SizedBox.shrink();
                        },
                        transitionBuilder: (_, anim, __, ___) {
                          final scale = Tween<double>(begin: 0.3, end: 1.0)
                              .animate(
                                CurvedAnimation(
                                  parent: anim,
                                  curve: Curves.easeOutBack,
                                ),
                              );

                          return Center(
                            child: Opacity(
                              opacity: anim.value,
                              child: Transform.scale(
                                scale:
                                    scale.value *
                                    1.50, // ← هذا ما يجعل الصورة ضخمة
                                child: Transform.rotate(
                                  angle: 1.5708, // 90 درجة
                                  child: Image.asset(
                                    'assets/022.png',
                                    fit: BoxFit.contain,
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.65,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset('assets/022.png', fit: BoxFit.cover),
                    ),
                  ),

                  /*child: GestureDetector(
                    onTap: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: '',
                        barrierColor: Colors.black.withOpacity(0.60),
                        transitionDuration: const Duration(milliseconds: 350),
                        pageBuilder: (_, __, ___) {
                          return const SizedBox.shrink();
                        },
                        transitionBuilder: (_, anim, __, ___) {
                          final scale =
                              Tween<double>(begin: 0.3, end: 1.0).animate(
                            CurvedAnimation(
                                parent: anim, curve: Curves.easeOutBack),
                          );

                          return Center(
                            child: Opacity(
                              opacity: anim.value,
                              child: Transform.scale(
                                scale: scale.value *
                                    1.35, // ← هذا ما يجعل الصورة ضخمة
                                child: Transform.rotate(
                                  angle: 1.5708, // 90 درجة
                                  child: Image.asset(
                                    'assets/022.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset('assets/022.png', fit: BoxFit.cover),
                    ),
                  ),*/
                ),
              ),

              const SizedBox(height: 16),

              // ==== الأزرار الدائرية (مشاركة، نسخ، نجمة) ====
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // زر العرض/فتح الورقة + مشاركة
                    GestureDetector(
                      onTap: _openShareSheet,
                      child: _circleButton(
                        "assets/icons/share.png",
                      ), // أيقونة مشاركة صغيرة — استبدل بالـ asset الذي تريد
                    ),
                    const SizedBox(width: 10),
                    _circleButton("assets/icons/copy.png"),
                    const SizedBox(width: 10),
                    _circleButton("assets/icons/star.png"),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // QR + شعار (كما في كودك السابق)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 18),
                  Image.asset('assets/sa_logo.png', width: 180, height: 100),
                  const SizedBox(width: 35),
                  GestureDetector(
                    onTap: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: '',
                        barrierColor: Colors.black.withOpacity(
                          0.85,
                        ), // تغبيش الخلفية

                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (_, __, ___) {
                          return const SizedBox.shrink();
                        },
                        transitionBuilder: (_, anim, __, ___) {
                          final scale = Tween<double>(begin: 0.4, end: 1.0)
                              .animate(
                                CurvedAnimation(
                                  parent: anim,
                                  curve: Curves.easeOutBack,
                                ),
                              );

                          return Center(
                            child: Opacity(
                              opacity: anim.value,
                              child: AnimatedScale(
                                scale: scale.value,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutBack,
                                child: Container(
                                  width: 260, // ← الحجم الجديد بدل تكبير القديم
                                  height: 360,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/qr.png',
                                        width: 220,
                                        height: 220,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        dateNow,
                                        style: const TextStyle(
                                          fontSize: 26,
                                          color: Colors.black, // لون نص ثابت
                                          decoration: TextDecoration
                                              .none, // إزالة أي خط أو تسطير
                                          shadows: [], // إزالة أي ظل
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        timeNow,
                                        style: const TextStyle(
                                          fontSize: 26,
                                          color: Colors.black, // لون نص ثابت
                                          decoration: TextDecoration
                                              .none, // إزالة أي خط أو تسطير
                                          shadows: [], // إزالة أي ظل
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 130,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/qr.png', width: 110, height: 110),
                          const SizedBox(height: 8),
                          Text(dateNow, style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(
                            timeNow,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*Container(
                    width: 130,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/qr.png', width: 110, height: 110),
                        const SizedBox(height: 8),
                        Text(dateNow, style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),*/
                ],
              ),

              const SizedBox(height: 20),

              // عناصر المعلومات (عرض سريع بدون التكرار الكامل لأن الورقة الكاملة داخل الـ sheet)
              _item('نسخة', '5'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('الاسم', 'رائد بن محمد بن إبراهيم إبراهيم'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('رقم البطاقة', '1082319755'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('تاريخ الميلاد بالهجري', '1412/10/14هـ'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('تاريخ الانتهاء بالهجري', '1450/09/18هـ'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('مكان الميلاد', 'جده'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('الاسم بالإنجليزي', 'IBRAHIM, RAED MUHAMMED I'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('رقم الهوية بالإنجليزي', '1082319755'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('تاريخ الميلاد بالميلادي', '17/04/1992'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('تاريخ الانتهاء بالميلادي', '02/02/2029'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleButton(String imagePath) {
    return Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(
        color: Color(0xFF2A2A2A),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }

  Widget _item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            //crossAxisAlignment: CrossAxisAlignment.start,
            child: // [
                //const Icon(Icons.copy, color: Colors.white70, size: 22),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    //const SizedBox(height: 8),
                  ],
                ),
            //],
          ),
          SizedBox(width: 8),
          const Icon(Icons.copy, color: Colors.white70, size: 22),
          //const SizedBox(height: 4),
          //Container(height: 1, color: Colors.white24),
        ],
      ),
    );
  }
}
