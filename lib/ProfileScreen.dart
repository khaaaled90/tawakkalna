//import 'dart:js_util' as js_util;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'NationalIDScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  //Color _accentColor = Color(0xFF7B8BFF);
  Color _indicatorColor = Color(0xFF6B7CFF);

  final double _expandedHeight = 340;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Use CustomScrollView + SliverAppBar to replicate header + overlap avatar
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              expandedHeight: _expandedHeight,
              automaticallyImplyLeading: false,
              flexibleSpace: Directionality(
                textDirection: TextDirection.rtl,
                child: Stack(
                  children: [
                    // ===== خلفية الصورة =====
                    Positioned.fill(
                      child: Image.asset(
                        "assets/header_bg.png",
                        fit: BoxFit.cover,
                      ),
                    ),

                    // ===== طبقة تعتيم خفيفة =====
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.25),
                      ),
                    ),

                    // ===== عنوان + أزرار =====
                    Positioned(
                      top: 15,
                      left: 12,
                      right: 12,
                      child: Row(
                        children: [
                          Text(
                            'معلوماتي',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              shadows: [
                                Shadow(blurRadius: 6, color: Colors.black45)
                              ],
                            ),
                          ),
                          Spacer(),
                          _circleAction(Icons.edit),
                          SizedBox(width: 12),
                          _circleAction(Icons.settings),
                        ],
                      ),
                    ),

                    // ===== صندوق البحث =====
                    Positioned(
                      top: 120,
                      left: 24,
                      right: 24,
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 8)
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'ابحث في معلوماتي',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16),
                              ),
                            ),
                            Icon(Icons.search, color: Colors.black54),
                          ],
                        ),
                      ),
                    ),

                    // ===== صورة البروفايل =====
                    Positioned(
                      right: 22,
                      top: _expandedHeight - 90,
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 6),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 8)
                          ],
                          image: DecorationImage(
                            image: AssetImage('assets/avatar.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // White content area with rounded top corners that matches screenshots
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    // Spacer to push content below avatar overlap
                    const SizedBox(height: 12),

                    // top row: name, follower count, id etc (mirrors screenshot)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // الاسم
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'رائد إبراهيم',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // المتابعون - رقم الهوية
                          Row(
                            children: [
                              // رقم الهوية (يمين)
                              const Text(
                                'رقم الهوية: 1082319755',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black87),
                              ),
                              const Spacer(),
                              // المتابعون (يسار)
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  '95 المتابعون',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 16),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // العمر + الدولة
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _statBoxWithImage('المملكة العربية السعودية',
                                  'assets/v333.png'),
                              const SizedBox(width: 12),
                              _statBoxWithImage('35', 'assets/v555.png'),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // تاريخ الميلاد + فصيلة الدم
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _statBoxWithImage(
                                  '1992-04-17', 'assets/v222.png'),
                              const SizedBox(width: 50),
                              _statBoxWithImage('+0', 'assets/v444.png'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // TabBar area with thin indicator like screenshot
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          TabBar(
                            controller: _tabController,
                            indicatorColor: _indicatorColor,
                            labelColor: Colors.black87,
                            unselectedLabelColor: Colors.black45,
                            indicatorWeight: 3,
                            labelStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                            tabs: const [
                              Tab(text: 'بياناتي'),
                              Tab(text: 'بطاقاتي'),
                              Tab(text: 'مستنداتي'),
                              Tab(text: 'سيرتي'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // TabBarView container
                    SizedBox(
                      height:
                          880, // give it enough height for scrolling inside whole page
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // بياناتي
                          // =================== تبويب بياناتي ===================
                          SingleChildScrollView(
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 🔵 العنوان الرئيسي
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.person_outline, size: 28),
                                        SizedBox(width: 8),
                                        Text(
                                          "المعلومات الشخصية",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                  // 🗺️ خريطة كصندوق كما في الصورة
                                  GestureDetector(
                                    onTap: () =>
                                        _showNationalAddressSheet(context),
                                    child: Container(
                                      padding: const EdgeInsets.all(18),
                                      height: 220,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        image: const DecorationImage(
                                          image: AssetImage("assets/map2.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // ☎️ رقم التواصل
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 18),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 6,
                                              offset: Offset(0, 2))
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              //const Icon(Icons.edit_outlined),
                                              //const SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                      "رقم التواصل الشخصي",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    Text(
                                                      textAlign:
                                                          TextAlign.right,
                                                      "966561226355+",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              const Icon(Icons.edit_outlined),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              //const Icon(Icons.edit_outlined),
                                              //const SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                      "البريد الإلكتروني",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 15),
                                                    ),
                                                    //const SizedBox(height: 1),
                                                    Text(
                                                      textAlign:
                                                          TextAlign.right,
                                                      "لا يوجد",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              const Icon(Icons.email_outlined),
                                            ],
                                          ),
                                          Center(
                                            child: TextButton(
                                              onPressed: () {
                                                _showMoreSheet(context);
                                              },
                                              child: const Text(
                                                "المزيد",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 11),
                                  // =======================  قسم المخالفات – السفر – الإنجازات  =======================

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      children: [
                                        // 🔴 المخالفات
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 16),
                                          margin:
                                              const EdgeInsets.only(bottom: 12),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 6)
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: [
                                                  Icon(Icons.block,
                                                      color:
                                                          Colors.red.shade400,
                                                      size: 30),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                          "المخالفات",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(height: 3),
                                                        Text(
                                                          "تحقق من أي مخالفات وغرامات مُبلغ عنها",
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Transform.rotate(
                                                    angle: 3.14, // 180 درجة
                                                    child: const Icon(
                                                        Icons.arrow_back_ios,
                                                        size: 18,
                                                        color: Colors.black45),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: [
                                                  Icon(Icons.travel_explore,
                                                      color:
                                                          Colors.blue.shade600,
                                                      size: 30),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                          "السفر",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(height: 3),
                                                        Text(
                                                          "اكتشف رحلاتك وتاريخ سفرك",
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Transform.rotate(
                                                    angle: 3.14, // 180 درجة
                                                    child: const Icon(
                                                        Icons.arrow_back_ios,
                                                        size: 18,
                                                        color: Colors.black45),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: [
                                                  Icon(Icons.military_tech,
                                                      color:
                                                          Colors.amber.shade700,
                                                      size: 30),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Text(
                                                          "الإنجازات",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(height: 3),
                                                        Text(
                                                          "اطّلع على إنجازاتك وجوائزك",
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black54),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Transform.rotate(
                                                    angle: 3.14, // 180 درجة
                                                    child: const Icon(
                                                        Icons.arrow_back_ios,
                                                        size: 18,
                                                        color: Colors.black45),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),

                          // بطاقاتي
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                _sectionTitle('المركبات'),
                                const SizedBox(height: 12),
                                SizedBox(
                                  height: 210,
                                  child: ListView(
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    children: [
                                      _imageCard("assets/driving_license.png",
                                          width: 320),
                                      const SizedBox(width: 12),
                                      _imageCard("assets/id_card.png",
                                          width: 320),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),

                          // مستنداتي
                          // ===================== تبويب مستنداتي =====================
                          SingleChildScrollView(
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ---------- العنوان ----------
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Text(
                                      "جوازات السفر",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),

                                  // ---------- كرت الجواز ----------
                                  Container(
                                    padding: EdgeInsets.all(18),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RotatedBox(
                                          quarterTurns: 3,
                                          child: Text(
                                            "V872997",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        RotatedBox(
                                          quarterTurns:
                                              3, // لجعل النص عمودي كما بالصورة
                                          child: Text(
                                            "رائد بن محمد بن ابراهيم ابراهيم",
                                            style: TextStyle(
                                                fontSize: 18, height: 1.3),
                                          ),
                                        ),
                                        // --- صورة الجواز (يسار) ---
                                        SizedBox(width: 20),
                                        Container(
                                          width: 120,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Colors.white,
                                          ),
                                          child: Image.asset(
                                            "assets/passport_sample.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),

                          // سيرتي
                          // ===================== تبويب سيرتي =====================
                          SingleChildScrollView(
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _cvItem(
                                    title: "المؤهلات التعليمية",
                                    subtitle:
                                        "لا يوجد لديك مؤهلات دراسية حالياً",
                                  ),
                                  _divider(),
                                  _cvItem(
                                    title: "الخبرات الوظيفية",
                                    subtitle:
                                        "لا يوجد لديك خبرات وظيفية حالياً",
                                  ),
                                  _divider(),
                                  _cvItem(
                                    title: "الهواية أو الموهبة",
                                    subtitle:
                                        "لا يوجد لديك هوايات أو مواهب حالياً",
                                  ),
                                  _divider(),
                                  _cvItem(
                                    title: "حسابات التواصل الاجتماعي",
                                    subtitle:
                                        "لا يوجد لديك حسابات تواصل اجتماعي حالياً",
                                  ),
                                  _divider(),
                                  _cvItem(
                                    title: "اللغات",
                                    subtitle: "لا يوجد لديك لغات حالياً",
                                  ),
                                  _divider(),
                                  _cvItem(
                                    title: "الدبلوم التربوي والبرنامج التأهيلي",
                                    subtitle:
                                        "لا يوجد لديك دبلومات تربوية أو برنامج تأهيلي حالياً",
                                  ),
                                  _divider(),
                                  _cvItem(
                                    title: "الدورات التأهيلية",
                                    subtitle:
                                        "لا يوجد لديك دورات تأهيلية حالياً",
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(text,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _imageCard(String asset, {double width = 300}) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(asset, fit: BoxFit.cover),
      ),
    );
  }

  Widget _bottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.black45,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'معلوماتي'),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'الرسائل'),
        BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'الخدمات'),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: 'واكب'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'توكّلنا'),
      ],
    );
  }

  Widget _statBoxWithImage(String label, String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _circleAction(IconData icon) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Icon(icon, color: Colors.black54),
    );
  }
}

Widget _divider() {
  return Container(
    width: double.infinity,
    height: 1.2,
    color: Colors.grey.shade300,
    margin: const EdgeInsets.symmetric(horizontal: 10),
  );
}

Widget _cvItem({required String title, required String subtitle}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 15, color: Colors.black54),
        ),
      ],
    ),
  );
}

void _showMoreSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.25,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== handle =====
                  Container(
                    width: 60,
                    height: 6,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  // ===== header (title + logos + toggle) =====
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 1),
                      child: Image.asset(
                        "assets/gov_emblem.png", // ضع الشعار في assets
                        width: 400,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Expanded(
                    //child:Directionality(
                    //textDirection: TextDirection.rtl,

                    child: ListView(
                      controller: scrollController,
                      children: [
                        const SizedBox(height: 6),
                        _sheetRow(
                            label: 'رقم الهوية',
                            value: '1082319755',
                            onCopy: () {
                              Clipboard.setData(
                                  const ClipboardData(text: '1082319755'));
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('تم نسخ رقم الهوية')),
                              );
                            }),
                        _sheetRow(
                            label: 'الاسم',
                            value: 'رائد بن محمد بن ابراهيم ابراهيم',
                            onCopy: () {
                              Clipboard.setData(const ClipboardData(
                                  text: 'رائد بن محمد بن ابراهيم ابراهيم'));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('تم نسخ الاسم')));
                            }),
                        _sheetRow(
                            label: 'الجنسية',
                            value: 'المملكة العربية السعودية',
                            onCopy: () {
                              Clipboard.setData(const ClipboardData(
                                  text: 'المملكة العربية السعودية'));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('تم النسخ')));
                            }),
                        _sheetRow(
                            label: 'مكان الميلاد',
                            value: 'جدة',
                            onCopy: () {
                              Clipboard.setData(
                                  const ClipboardData(text: 'جدة'));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('تم النسخ')));
                            }),
                        _sheetRow(
                            label: 'الحالة الاجتماعية',
                            value: 'متزوج',
                            onCopy: () {
                              Clipboard.setData(
                                  const ClipboardData(text: 'متزوج'));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('تم النسخ')));
                            }),
                        _sheetRow(
                            label: 'المؤهل',
                            value: 'لا يوجد',
                            onCopy: () {
                              Clipboard.setData(
                                  const ClipboardData(text: 'لا يوجد'));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('تم النسخ')));
                            }),
                        _sheetRow(
                            label: 'المهنة',
                            value: '-',
                            onCopy: () {
                              Clipboard.setData(const ClipboardData(text: '-'));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('تم النسخ')));
                            }),
                        _sheetRow(
                            label: 'البريد الإلكتروني',
                            value: 'لا يوجد',
                            onCopy: () {
                              Clipboard.setData(
                                  const ClipboardData(text: 'لا يوجد'));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('تم النسخ')));
                            }),
                        _sheetRow(
                            label: 'رقم التواصل الشخصي',
                            value: '+966561226355',
                            onCopy: () {
                              Clipboard.setData(
                                  const ClipboardData(text: '+966561226355'));
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('تم نسخ رقم الجوال')));
                            }),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  //),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

// مساعدة: صف واحد داخل الورقة (يمكن تعديله للتصميم الدقيق)
Widget _sheetRow(
    {required String label,
    required String value,
    required VoidCallback onCopy}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      textDirection: TextDirection.rtl,
      children: [
        // أيقونة نسخ على اليسار (في RTL ستكون على اليسار تلقائياً)
        // قيمة الحقل
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
            ],
          ),
        ),

        const SizedBox(width: 5),

        IconButton(
          onPressed: onCopy,
          icon: const Icon(Icons.copy_outlined),
          splashRadius: 20,
        ),
      ],
    ),
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
                            _divider1(),
                            _infoRow(context,
                                title: "رقم المبنى", value: "2471"),
                            _divider1(),
                            _infoRow(context, title: "الحي", value: "النسيم"),
                            _divider1(),
                            _infoRow(context,
                                title: "الرمز الاضافي", value: "4397"),
                            _divider1(),
                            _infoRow(context,
                                title: "الرمز البريدي", value: "22343"),
                            _divider1(),
                            _infoRow(context, title: "الشارع", value: "الثقة"),
                            _divider1(),
                            _infoRow(context, title: "المدينة", value: "جدة"),
                            const SizedBox(height: 8),

                            // زر المشاركة الكبير
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
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
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("تم نسخ القيمة")));
            },
            icon: const Icon(Icons.copy_outlined, size: 26),
            color: Colors.grey[700],
          ),
        ],
      ),
    ),
  );
}

Widget _divider1() => Divider(color: Colors.grey[300], height: 1);
