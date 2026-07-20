import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'DrivingCScreen.dart';
import 'NationalIDScreen.dart';
import 'DrivingDScreen.dart';
import 'ProfileScreen.dart';
import 'ToggleBlurCard.dart';
import 'tawakkalna_bottom_bar.dart';

class TawakkalnaScreen extends StatelessWidget {
  const TawakkalnaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // تحديد اتجاه النص من اليمين لليسار
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7), // اللون الخلفي
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // محاذاة العناصر لليمين
                children: [
                  // ------------------ Header -------------------
                  Padding(
                    padding: EdgeInsets.fromLTRB(1, 20, 1, 10),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 23,
                          backgroundColor: Colors.blue,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage("assets/avatar.png"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            "هلا علاء!\nWeather - حدد مدينتك المفضلة",
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.4,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right, // محاذاة النص لليمين
                          ),
                        ),
                        Image.asset(
                          'assets/0xx2.png',
                          width:
                              40, // عرض الصورة (يمكن تعديله حسب الحجم المطلوب)
                          height: 40, // ارتفاع الصورة
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ------------------ Search Box -------------------
                  TextField(
                    textAlign: TextAlign.right, // محاذاة النص لليمين
                    decoration: InputDecoration(
                      hintText: "ابحث في توكلنا",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // ------------------ Quick Access -------------------
                  const Text(
                    "الوصول السريع",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/fs0023.png",
                          width: 100, // عرض الصورة
                          height: 50, // ارتفاع الصورة
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                          "assets/fs0022.png",
                          width: 100,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                          "assets/fs0021.png",
                          width: 100,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                          "assets/fs0020.png",
                          width: 100,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "البطاقات المفضلة",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          TawakkalnaHome.globalKey.currentState?.changeTab(4);
                        },
                        child: const Text(
                          "عرض الكل",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ToggleBlurCard(
                          imagePath: "assets/022.png",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const NationalIDScreen(),
                              ),
                            );
                          },
                        ),
                        /*const SizedBox(width: 10),
                        ToggleBlurCard(
                          imagePath: "assets/023.png",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DrivingDScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        ToggleBlurCard(
                          imagePath: "assets/024.png",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DrivingCScreen(),
                              ),
                            );
                          },
                        ),*/
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ------------------ Explore Categories -------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "استكشف التصنيفات",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "عرض الكل",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  _gridCategories(),

                  const SizedBox(height: 30),

                  // ------------------ Preferred Center -------------------
                  const Text(
                    "مركز المفضلة",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),

                  Container(
                    height: 180,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage('assets/fs007.png'), // مسار الصورة
                        fit: BoxFit.contain, // لتملأ الخلفية بالكامل
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  GestureDetector(
                    onTap: () => _showNationalAddressSheet(context),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      height: 210,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        image: const DecorationImage(
                          image: AssetImage("assets/map_placeholder.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ------------------ Help -------------------
                  const Text(
                    "هل تحتاج مساعدة؟",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    height: 150,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage('assets/fs009.png'), // مسار الصورة
                        fit: BoxFit.contain, // لتملأ الخلفية بالكامل
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
        //bottomNavigationBar: _bottomNav(),
      ),
    );
  }

  // ========== Widgets ==========
  //
  Widget _quickItem(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      //width: 10, // التحكم في عرض المربع
      height: 50, // التحكم في ارتفاع المربع
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green, size: 30), // تغيير حجم الأيقونة
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 14),
          ), // التحكم في حجم النص
        ],
      ),
    );
  }

  Widget _gridCategories() {
    // مسارات الصور لكل عنصر
    final imagePaths = [
      "assets/fs0010.png", // الدينية
      "assets/fs0011.png", // الشخصية والأسرة
      "assets/fs0012.png", // الاتصالات والتقنية
      "assets/fs0013.png", // المركبات والمرور
      "assets/fs0014.png", // التعليم
      "assets/fs0015.png", // التجارة والمالية
      "assets/fs0016.png", // السياحة والفعاليات
      "assets/fs0017.png",
      "assets/fs0018.png",
      //"assets/fs0019.png", // التسوق والعقارات
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.1,
      children: imagePaths
          .map(
            (path) => Container(
              margin: const EdgeInsets.all(6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(path, fit: BoxFit.contain),
              ),
            ),
          )
          .toList(),
    );
  }

  //
  //
  Widget _cardButton(String image, VoidCallback onTap) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isBlurred = false;

        return GestureDetector(
          onTap: onTap,
          onLongPress: () {
            setState(() {
              isBlurred = !isBlurred; // تشغيل / إطفاء الضبابية
            });
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // الصورة
                Image.asset(image, width: 150, height: 100, fit: BoxFit.cover),

                // الضبابية
                if (isBlurred)
                  // ignore: dead_code
                  ClipRect(
                    // مهم جداً لكي يعمل الـ BackdropFilter
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        width: 150,
                        height: 100,
                        color: Colors.black.withOpacity(
                          0.20,
                        ), // تعتيم بسيط + Blur
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _favoriteCenterItem(String text, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.green, size: 30),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }

  // دالة إظهار الـ Bottom Sheet القابلة للسحب
  void _showNationalAddressSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // للسماح بالارتفاع الكبير
      backgroundColor: Colors.transparent, // لعمل زوايا منحنية
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65, // الحجم الابتدائي من الشاشة
          minChildSize: 0.3,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // المقبض الصغير
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        width: 60,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    // المحتوى قابل للتمرير
                    Expanded(
                      child: SingleChildScrollView(
                        controller:
                            scrollController, // مهم لربط التمرير بالـ DraggableScrollableSheet
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 2,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // عنوان الورقة
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1),
                                  child: Text(
                                    "العنوان الأول",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              // شعار وصورة كبيرة
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 1,
                                  ),
                                  child: Image.asset(
                                    "assets/address_log.png", // ضع الشعار في assets
                                    width: 450,
                                    height: 120,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 4),

                              // مثال على صفوف البيانات مع أيقونة نسخ
                              _infoRow(
                                context,
                                title: "العنوان المختصر",
                                value: "MDHA2300",
                              ),
                              _divider(),
                              _infoRow(
                                context,
                                title: "رقم المبنى",
                                value: "2300",
                              ),
                              _divider(),
                              _infoRow(
                                context,
                                title: "الحي",
                                value: "حي الحديبية",
                              ),
                              _divider(),
                              _infoRow(
                                context,
                                title: "الرمز الاضافي",
                                value: "8555",
                              ),
                              _divider(),
                              _infoRow(
                                context,
                                title: "الرمز البريدي",
                                value: "24336",
                              ),
                              _divider(),
                              _infoRow(
                                context,
                                title: "الشارع",
                                value: "شارع 346 الحديبية 1",
                              ),
                              _divider(),
                              _infoRow(
                                context, 
                                title: "المدينة", 
                                value: "مكة المكرمة"),
                              const SizedBox(height: 8),

                              // زر المشاركة الكبير
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // هنا يمكن فتح 
                                    //دالة المشاركة (share) أو نسخ رابط
                                    // مثال بسيط: نسخ "NAF2471" إلى الحافظة
                                    Clipboard.setData(
                                      const ClipboardData(text: "https://maps.app.goo.gl/HJH4m7taSNTfdhn9A"),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("تم نسخ العنوان"),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                  label: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    child: Text(
                                      "مشاركة عنوانك",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _infoRow(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return InkWell(
      onTap: () {
        // نسخ القيمة عند النقر على الصف بالكامل (اختياري)
        Clipboard.setData(ClipboardData(text: value));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("تم نسخ القيمة")));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // النصوص على اليمين (العنوان ثم القيمة)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // أيقونة النسخ على اليسار
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("تم نسخ القيمة")));
              },
              icon: const Icon(Icons.copy_outlined, size: 26),
              color: Colors.grey[700],
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Divider(color: Colors.grey[300], height: 1);
}
