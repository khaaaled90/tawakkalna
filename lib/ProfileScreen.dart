import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'DrivingDScreen.dart';
import 'NationalIDScreen.dart';
import 'PassportIDScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: NestedScrollView(
          physics: const ClampingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              // ===== 1. الهيدر والبيانات الشخصية =====
              SliverAppBar(
                pinned: false,
                elevation: 0,
                backgroundColor: Colors.transparent,
                expandedHeight: _expandedHeight,
                automaticallyImplyLeading: false,
                flexibleSpace: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          "assets/header_bg.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(color: Colors.black.withOpacity(0.25)),
                      ),
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
                                  Shadow(blurRadius: 6, color: Colors.black45),
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
                              BoxShadow(color: Colors.black26, blurRadius: 8),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'ابحث في معلوماتي',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Icon(Icons.search, color: Colors.black54),
                            ],
                          ),
                        ),
                      ),
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
                              BoxShadow(color: Colors.black26, blurRadius: 8),
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

              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'رائد إبراهيم',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Text(
                                  'رقم الهوية: 1082319755',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    '95 المتابعون',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _statBoxWithImage(
                                      'المملكة العربية السعودية',
                                      'assets/v333.png',
                                    ),
                                    const SizedBox(height: 10),
                                    _statBoxWithImage(
                                      '1992-04-17',
                                      'assets/v222.png',
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _statBoxWithImage('35', 'assets/v555.png'),
                                    const SizedBox(height: 10),
                                    _statBoxWithImage('+0', 'assets/v444.png'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),

              // ===== 2. تثبيت الـ TabBar وحساب الإزاحة ديناميكياً لتفادي الاختفاء خلفه =====
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
                sliver: SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: _indicatorColor,
                        labelColor: Colors.black87,
                        unselectedLabelColor: Colors.black45,
                        indicatorWeight: 3,
                        labelStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        tabs: const [
                          Tab(text: 'بياناتي'),
                          Tab(text: 'بطاقاتي'),
                          Tab(text: 'مستنداتي'),
                          Tab(text: 'سيرتي'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              // =================== 1. تبويب بياناتي ===================
              _buildTabContent(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.person_outline, size: 28),
                              SizedBox(width: 8),
                              Text(
                                "المعلومات الشخصية",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => _showNationalAddressSheet(context),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "رقم التواصل الشخصي",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "+966561226355",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black54,
                                            ),
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "البريد الإلكتروني",
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            "لا يوجد",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black54,
                                            ),
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
                                    onPressed: () => _showMoreSheet(context),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 6),
                              ],
                            ),
                            child: Column(
                              children: [
                                _buildMenuRow(
                                  Icons.block,
                                  Colors.red.shade400,
                                  "المخالفات",
                                  "تحقق من أي مخالفات وغرامات مُبلغ عنها",
                                ),
                                _buildMenuRow(
                                  Icons.travel_explore,
                                  Colors.blue.shade600,
                                  "السفر",
                                  "اكتشف رحلاتك وتاريخ سفرك",
                                ),
                                _buildMenuRow(
                                  Icons.military_tech,
                                  Colors.amber.shade700,
                                  "الإنجازات",
                                  "اطّلع على إنجازاتك وجوائزك",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // =================== 2. تبويب بطاقاتي ===================
              _buildTabContent(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _imageCard(
                          "assets/id_card.png",
                          width: double.infinity,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NationalIDScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 14),
                        _imageCard(
                          "assets/driving_license.png",
                          width: double.infinity,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DrivingDScreen(),
                              ),
                            );
                          },
                        ),
                      ]),
                    ),
                  ),
                ],
              ),

              // =================== 3. تبويب مستنداتي ===================
              _buildTabContent(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: Text(
                            "جوازات السفر",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(22),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PassportDetails(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(18),
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  quarterTurns: 3,
                                  child: Text(
                                    "رائد بن محمد بن ابراهيم ابراهيم",
                                    style: TextStyle(fontSize: 18, height: 1.3),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 130,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                  ),
                                  child: Image.asset(
                                    "assets/passport_sample.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // =================== 4. تبويب سيرتي ===================
              _buildTabContent(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _cvItem(
                          title: "المؤهلات التعليمية",
                          subtitle: "لا يوجد لديك مؤهلات دراسية حالياً",
                        ),
                        _divider(),
                        _cvItem(
                          title: "الخبرات الوظيفية",
                          subtitle: "لا يوجد لديك خبرات وظيفية حالياً",
                        ),
                        _divider(),
                        _cvItem(
                          title: "الهواية أو الموهبة",
                          subtitle: "لا يوجد لديك هوايات أو مواهب حالياً",
                        ),
                        _divider(),
                        _cvItem(
                          title: "حسابات التواصل الاجتماعي",
                          subtitle: "لا يوجد لديك حسابات تواصل اجتماعي حالياً",
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
                          subtitle: "لا يوجد لديك دورات تأهيلية حالياً",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== الدالة المساعدة المثالية والمصححة بالكامل بدون أي Map يدوي لمنع أخطاء الـ Compiling =====
  Widget _buildTabContent({required List<Widget> slivers}) {
    return Builder(
      builder: (BuildContext context) {
        return CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            // يحجز مساحة علوية مطابقة تماماً لارتفاع التبويبات المثبتة لمنع اختفاء المحتوى خلفها
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            // حقن الـ Directionality لدعم اللغة العربية (RTL) بطريقة متوافقة تماماً مع الـ Slivers
            SliverPadding(
              padding: EdgeInsets.zero,
              sliver: SliverToBoxAdapter(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: const SizedBox.shrink(),
                ),
              ),
            ),
            // دمج قائمة الـ Slivers الأصلية الممرة مباشرة
            ...slivers,
            // مسافة أمان سفلية مريحة للتمرير
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        );
      },
    );
  }

  Widget _buildMenuRow(
    IconData icon,
    Color color,
    String title,
    String subtitle,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  subtitle,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
          Transform.rotate(
            angle: 3.14,
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageCard(String asset, {double width = 300, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(asset, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _statBoxWithImage(String label, String imagePath) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath, width: 20, height: 20, fit: BoxFit.contain),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final Widget _tabBar;

  @override
  double get minExtent => 48.0;
  @override
  double get maxExtent => 48.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}

Widget _divider() {
  return Divider(
    color: Colors.grey.shade300,
    height: 1,
    indent: 10,
    endIndent: 10,
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

// دالات الـ Bottom Sheets مضافة بالكامل كما هي ليعمل الملف بشكل مستقل وصحيح ومباشر
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
                children: [
                  Container(
                    width: 60,
                    height: 6,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 1),
                      child: Image.asset(
                        "assets/gov_emblem.png",
                        width: 400,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        const SizedBox(height: 6),
                        _sheetRow(
                          label: 'رقم الهوية',
                          value: '1082319755',
                          onCopy: () {
                            Clipboard.setData(
                              const ClipboardData(text: '1082319755'),
                            );
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تم نسخ رقم الهوية'),
                              ),
                            );
                          },
                        ),
                        _sheetRow(
                          label: 'الاسم',
                          value: 'رائد بن محمد بن ابراهيم ابراهيم',
                          onCopy: () {
                            Clipboard.setData(
                              const ClipboardData(
                                text: 'رائد بن محمد بن ابراهيم ابراهيم',
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم نسخ الاسم')),
                            );
                          },
                        ),
                        _sheetRow(
                          label: 'الجنسية',
                          value: 'المملكة العربية السعودية',
                          onCopy: () {
                            Clipboard.setData(
                              const ClipboardData(
                                text: 'المملكة العربية السعودية',
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم النسخ')),
                            );
                          },
                        ),
                        _sheetRow(
                          label: 'مكان الميلاد',
                          value: 'جدة',
                          onCopy: () {
                            Clipboard.setData(const ClipboardData(text: 'جدة'));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم النسخ')),
                            );
                          },
                        ),
                        _sheetRow(
                          label: 'الحالة الاجتماعية',
                          value: 'متزوج',
                          onCopy: () {
                            Clipboard.setData(
                              const ClipboardData(text: 'متزوج'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم النسخ')),
                            );
                          },
                        ),
                        _sheetRow(
                          label: 'المؤهل',
                          value: 'لا يوجد',
                          onCopy: () {
                            Clipboard.setData(
                              const ClipboardData(text: 'لا يوجد'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم النسخ')),
                            );
                          },
                        ),
                        _sheetRow(
                          label: 'المهنة',
                          value: '-',
                          onCopy: () {
                            Clipboard.setData(const ClipboardData(text: '-'));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم النسخ')),
                            );
                          },
                        ),
                        _sheetRow(
                          label: 'البريد الإلكتروني',
                          value: 'لا يوجد',
                          onCopy: () {
                            Clipboard.setData(
                              const ClipboardData(text: 'لا يوجد'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم النسخ')),
                            );
                          },
                        ),
                        _sheetRow(
                          label: 'رقم التواصل الشخصي',
                          value: '+966561226355',
                          onCopy: () {
                            Clipboard.setData(
                              const ClipboardData(text: '+966561226355'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تم نسخ رقم الجوال'),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
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

Widget _sheetRow({
  required String label,
  required String value,
  required VoidCallback onCopy,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
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

void _showNationalAddressSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.65,
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
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 2,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
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
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 1,
                                ),
                                child: Image.asset(
                                  "assets/address_log.png",
                                  width: 450,
                                  height: 120,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            _infoRow(
                              context,
                              title: "العنوان المختصر",
                              value: "NAF2471",
                            ),
                            _divider1(),
                            _infoRow(
                              context,
                              title: "رقم المبنى",
                              value: "2471",
                            ),
                            _divider1(),
                            _infoRow(context, title: "الحي", value: "النسيم"),
                            _divider1(),
                            _infoRow(
                              context,
                              title: "الرمز الاضافي",
                              value: "4397",
                            ),
                            _divider1(),
                            _infoRow(
                              context,
                              title: "الرمز البريدي",
                              value: "22343",
                            ),
                            _divider1(),
                            _infoRow(context, title: "الشارع", value: "الثقة"),
                            _divider1(),
                            _infoRow(context, title: "المدينة", value: "جدة"),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Clipboard.setData(
                                    const ClipboardData(text: "NAF2471"),
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

Widget _divider1() => Divider(color: Colors.grey[300], height: 1);
