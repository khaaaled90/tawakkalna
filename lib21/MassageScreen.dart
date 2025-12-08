import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // الخلفية البيضاء
      appBar: AppBar(
        elevation: 0, // إزالة الظلال
        backgroundColor: Colors.white, // خلفية شفافة
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // توزيع المحتويات بين اليسار واليمين
          children: [
            // زر "الكل" في الجهة اليسرى
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Text(
                'الرسائل',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              /*child Text(
                  'الرسائل',
                  style: TextStyle(
                    fontSize: 42, 
                    fontWeight: FontWeight.w700),
                ),*/
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // توزيع المحتويات بين اليسار واليمين

          children: [
            // حقل البحث في الأعلى
            const SizedBox(
                height: 16), // المسافة بين شريط البحث والمحتوى التالي
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // توزيع المحتويات بين اليسار واليمين

                children: [
                  //Icon(Icons.search, color: Colors.grey),
                  //SizedBox(width: 8),
                  Text(
                    'ابحث في توكلنا',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.search, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 12), // المسافة بين حقل البحث والرسالة

            // الرسالة في أسفل الشاشة
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width *
                          0.98, // 98% من عرض الشاشة
                      height: MediaQuery.of(context).size.height *
                          0.60, // 60% من ارتفاع الشاشة
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: AssetImage('assets/0x7.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
