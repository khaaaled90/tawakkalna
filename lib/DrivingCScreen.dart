import 'dart:io';
//import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:pdf/pdf.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class DrivingCScreen extends StatefulWidget {
  const DrivingCScreen({super.key});

  @override
  State<DrivingCScreen> createState() => _DrivingCScreenState();
}

class _DrivingCScreenState extends State<DrivingCScreen> {
  // مفتاح لالتقاط صورة للورقة (RepaintBoundary)
  final GlobalKey _paperKey = GlobalKey();

  // بيانات وهمية كما في الصورة — عدّلها إن أحببت
  final Map<String, String> leftData = {
    'هوية المالك/Number ID': '1082319755',
    'هوية المستخدم/Co Owner ID ': 'null',
    'ماركة المركبة/Name Car': 'تويوتا',
    'سنة الصنع/Year Car': '2001',
    'التسلسيل الرقم/Serial Number': '519443500',
    'رقم اللوحة باإلنجلزيي/Plate': 'N G A 1436',
    'نوع التسجيل/Specialty Car': 'خاص',
    'وزن املركبة/Weight Car': '0',
    'بالهجري اإلصدار تاريخ/Issue in Hijri': '1422/06/28',
    'بالهجري الانهتاء تاريخ/Issue in Hijri': '1438/12/03',
  };

  final Map<String, String> rightData = {
    'الاسم/ Owner': 'رائد بن محمد بن إبراهيم إبراهيم',
    'المستخدم/Co Owner Name': 'null',
    'طراز المركبة/Car Model': 'كامري',
    'رقم الهيكل/Car Register': '6T1BG21K01X453043هـ',
    'رقم اللوحة/': 'أ ق ن 1436',
    'لون املركبة/ Color Car': 'ابيض',
    'حمولة املركبة/': '0',
    'تاريخ الإصدار/Date Issue': '16/09/2001',
    'تاريخ االنهتاء/Date Expire': '25/08/2017',
    'تاريخ اخر فحص دوري/date inspection': 'null',
  };

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

  Future<void> _captureAndSharePdf() async {
    try {
      final now = DateTime.now();

      final datePart =
          '${now.year.toString().padLeft(4, '0')}-'
          '${now.month.toString().padLeft(2, '0')}-'
          '${now.day.toString().padLeft(2, '0')}';

      final String fileName = 'رخصة سير_$datePart.pdf';

      // قراءة ملف PDF من assets
      final byteData = await rootBundle.load('assets/3.pdf');

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
                image: AssetImage('assets/vz223.png'), // اسم ملف الصورة الخلفية
                fit: BoxFit
                    .fill, // أو BoxFit.fill / BoxFit.fitWidth حسب الشكل المطلوب
              ),
            ),
          ),

          const SizedBox(height: 15),

          // =================== NATIONAL ID CARD IMAGE ===================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/024.png",
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
            'رخصة سير',
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
                  //child: //Image.asset('assets/024.png', fit: BoxFit.cover),
                  child: GestureDetector(
                    onTap: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: '',
                        barrierColor: Colors.black.withOpacity(0.92),
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
                                    1.35, // ← هذا ما يجعل الصورة ضخمة
                                child: Transform.rotate(
                                  angle: 1.5708, // 90 درجة
                                  child: Image.asset(
                                    'assets/024.png',
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
                      child: Image.asset('assets/024.png', fit: BoxFit.cover),
                    ),
                  ),
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
                ],
              ),

              const SizedBox(height: 20),

              // عناصر المعلومات (عرض سريع بدون التكرار الكامل لأن الورقة الكاملة داخل الـ sheet)
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '  الخدمات المرتبطة',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              _item('الرقم', '1082319755'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('الاسم', 'رائد بن محمد بن إبراهيم إبراهيم'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('المستخدم هوية', 'null'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('المستخدم', 'null'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('ماركة المركبة', 'تويوتا'),
              Container(height: 1, color: Colors.white24),
              _item('طراز المركبة', 'كامري'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('سنة الصنع', '2001'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('رقم الهيكل', '6T1BG21K01X453043'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('رقم اللوحة', 'أ ق ن 1436'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('رقم اللوحة بالانجليزي', 'N G A 1436'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('لون المركبة', 'ابيض'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('نوع التسجيل', 'خاص'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('حمولة المركبة', '0'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('وزن المركبة', '0'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('تاريخ الاصدار', '16/09/2001'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('تاريخ الاصدار بالهجري', '1422/06/28'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('تاريخ الانتهاء', '25/08/2017'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('تاريخ الانتهاء بالهجري', '1438/12/03'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('تاريخ اخر فحص دوري', 'null'),
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
