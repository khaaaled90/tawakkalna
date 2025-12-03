import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'NationalIDScreen.dart';
import 'DrivingDScreen.dart';
import 'ProfileScreen.dart';

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
                            "هلا رائد!\nWeather - حدد مدينتك المفضلة",
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.4,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right, // محاذاة النص لليمين
                          ),
                        ),
                        /*const CircleAvatar(
                            radius: 23,
                            backgroundImage: AssetImage("assets/avatar.png"),
                          ),*/
                        //const CircleAvatar(
                        //radius: 23,
                        //backgroundColor: Colors.black12,
                        //child: Icon(Icons.favorite, color: Colors.black45),
                        //),
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
                  const Text("الوصول السريع",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),

                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _quickItem("الجهات", Icons.apartment),
                      _quickItem("المستندات", Icons.description),
                      _quickItem("إحسان", Icons.favorite),
                      _quickItem("التقويم", Icons.calendar_today),
                    ],
                  ),*/
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

                  /*SingleChildScrollView(
                    scrollDirection: Axis.horizontal, // تفعيل التمرير الأفقي
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // ترتيب العناصر من اليسار
                      children: [
                        _quickItem("الجهات", Icons.apartment),
                        _quickItem("المستندات", Icons.description),
                        _quickItem("إحسان", Icons.favorite),
                        _quickItem("التقويم", Icons.calendar_today),
                        // إضافة المزيد من العناصر حسب الحاجة
                      ],
                    ),
                  ),*/

                  const SizedBox(height: 25),

                  // ------------------ Favorite Cards -------------------
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("البطاقات المفضلة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("عرض الكل", style: TextStyle(color: Colors.green)),
                    ],
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "البطاقات المفضلة",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProfileScreen()),
                          );
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
                        _cardButton("assets/022.png", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const NationalIDScreen()),
                          );
                        }),
                        const SizedBox(width: 10),
                        _cardButton("assets/023.png", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const DrivingDScreen()),
                          );
                        }),
                        /*const SizedBox(width: 10),
                        _cardButton("assets/022.png", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const NationalIDScreen()),
                          );
                        }
                        ),*/
                      ],
                    ),
                  ),

                  /*Row(
                
                      children: [
                        Expanded(child: _cardImage("assets/022.png")),
                        const SizedBox(width: 10),
                        Expanded(child: _cardImage("assets/022.png")),
                      ],
                  ),*/

                  const SizedBox(height: 30),

                  // ------------------ Explore Categories -------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("استكشف التصنيفات",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("عرض الكل", style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  const SizedBox(height: 15),

                  _gridCategories(),

                  const SizedBox(height: 30),

                  // ------------------ Preferred Center -------------------
                  const Text("مركز المفضلة",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                    /*child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _favoriteCenterItem(
                            "بلاغ تحسين\nالمشهد الحضري", Icons.report),
                        _favoriteCenterItem("القبلة\n ", Icons.explore),
                        _favoriteCenterItem(
                            "النتائج الدراسية\n ", Icons.school),
                      ],
                    ),*/
                  ),

                  const SizedBox(height: 30),

/*
                  // ------------------ National Address -------------------
                  const Text("العنوان الوطني", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),

                  
                  Container(
                    padding: const EdgeInsets.all(18),
                    height: 210,
                    width: 700,
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage("assets/map_placeholder.png"),  // مسار الصورة من الـ assets
                        fit: BoxFit.fill,  // يمكن استخدام BoxFit.cover أو BoxFit.fill أو غيرها
                      ),
                    ),
                    
                    /*child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset("assets/map_placeholder.png", fit: BoxFit.fill),
                    ),*/
                  ),*/

                  // --- هنا وضعنا الحاوية التي عند النقر عليها تظهر ورقة العنوان ---
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
                  const Text("هل تحتاج مساعدة؟",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                    /*child: Row(
                      children: const [
                        Icon(Icons.help_outline, size: 28),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "نحن مستعدون للإجابة على أسئلتك\nالأسئلة الشائعة التفاعلية",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.right, // محاذاة النص لليمين
                          ),
                        ),
                      ],
                    ),*/
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _bottomNav(),
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
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green, size: 30), // تغيير حجم الأيقونة
          const SizedBox(width: 20),
          Text(title,
              style: const TextStyle(fontSize: 14)), // التحكم في حجم النص
        ],
      ),
    );
  }

  /*Widget _quickItem(String title, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
      ),
      
      child:Row(
        children: [
          /*CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white,
            child: Icon(icon, color: Colors.green, size: 30),
          ),*/
          Icon(icon, color: Colors.green, size: 20),
          const SizedBox(width: 4),
          Text(title, style: const TextStyle(fontSize: 13)),
        ],
      )
    );
  }*/

  /*Widget _cardImage(String path) {
    return Container(
      width: 160,  // تحديد عرض البطاقة
      height: 100, // تحديد ارتفاع البطاقة
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }*/

/*  Widget _cardImage(String path) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }
*/
  /*Widget _gridCategories() {
    final items = [
      "الدينية",
      "الصحة",
      "الشخصية والأسرة",
      "الاتصالات والتقنية",
      "المركبات والمرور",
      "التعليم",
      "التجارة والمالية",
      "السياحة والفعاليات",
      "التسوق والعقارات",
    ];*/

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
                child: Image.asset(
                  path,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  /*return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.1,
      children: items
          .map((e) => Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(e,
                      textAlign: TextAlign.center), // محاذاة النص لليمين
                ),
              ))
          .toList(),
    );
  }*/

  Widget _cardButton(String image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
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
        Text(text,
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 13)),
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
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
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
                              horizontal: 15, vertical: 2),
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
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),

                              // شعار وصورة كبيرة
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 1),
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
                              _infoRow(context,
                                  title: "العنوان المختصر", value: "NAF2471"),
                              _divider(),
                              _infoRow(context,
                                  title: "رقم المبنى", value: "2471"),
                              _divider(),
                              _infoRow(context, title: "الحي", value: "النسيم"),
                              _divider(),
                              _infoRow(context,
                                  title: "الرمز الاضافي", value: "4397"),
                              _divider(),
                              _infoRow(context,
                                  title: "الرمز البريدي", value: "22343"),
                              _divider(),
                              _infoRow(context,
                                  title: "الشارع", value: "الثقة"),
                              _divider(),
                              _infoRow(context, title: "المدينة", value: "جدة"),
                              const SizedBox(height: 8),

                              // زر المشاركة الكبير
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // هنا يمكن فتح دالة المشاركة (share) أو نسخ رابط
                                    // مثال بسيط: نسخ "NAF2471" إلى الحافظة
                                    Clipboard.setData(
                                        const ClipboardData(text: "NAF2471"));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("تم نسخ العنوان")),
                                    );
                                  },
                                  icon: const Icon(Icons.share),
                                  label: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    child: Text("مشاركة عنوانك",
                                        style: TextStyle(fontSize: 16)),
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

  Widget _infoRow(BuildContext context,
      {required String title, required String value}) {
    return InkWell(
      onTap: () {
        // نسخ القيمة عند النقر على الصف بالكامل (اختياري)
        Clipboard.setData(ClipboardData(text: value));
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("تم نسخ القيمة")));
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
                  Text(title,
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 3),
                  Text(value,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            // أيقونة النسخ على اليسار
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("تم نسخ القيمة")));
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

  Widget _bottomNav() {
    return BottomNavigationBar(
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "مبوماتي"),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "الرسائل"),
        BottomNavigationBarItem(icon: Icon(Icons.apps), label: "الخدمات"),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: "واكب"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "توكلنا"),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
