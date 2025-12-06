import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  final List<String> tabs = [
    'assets/2s.png',
    'assets/4s.png',
    'assets/6s.png',
    'assets/7s.png',
  ];
  final List<String> tabsSelected = [
    'assets/1s.png',
    'assets/3s.png',
    'assets/5s.png',
    'assets/8s.png',
  ];
  int currentIndex = 0;

  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        setState(() {
          currentIndex = tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),

              /// عنوان الصفحة
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Text(
                  'الخدمات',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                ),
              ),

              const SizedBox(height: 14),

              /// مربع البحث
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildSearchBox(),
              ),

              const SizedBox(height: 12),

              /// الـ Tabs باستخدام الصور فقط
              /*SizedBox(
                height: 40,
                child: TabBar(
                  controller: tabController,
                  indicatorColor: Colors.transparent, // بدون مؤشر
                  labelPadding: const EdgeInsets.symmetric(horizontal: 3),
                  tabs: tabs
                      .map(
                        (img) => SizedBox(
                          height: 35,
                          child: Image.asset(img, fit: BoxFit.fill),
                        ),
                      )
                      .toList(),
                ),
              ),*/
              /// الـ Tabs باستخدام الصور فقط
              SizedBox(
                height: 40,
                child: TabBar(
                  controller: tabController,
                  indicatorColor: Colors.transparent,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 3),
                  tabs: List.generate(tabs.length, (index) {
                    return SizedBox(
                      height: 35,
                      child: Image.asset(
                        currentIndex == index
                            ? tabsSelected[index] // الصورة عند التحديد
                            : tabs[index], // الصورة الافتراضية
                        fit: BoxFit.fill,
                      ),
                    );
                  }),
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    /// التاب الأول — محتوى كامل كما هو
                    _tabMainContent(),

                    /// التابات الأخرى — صور افتراضية
                    _placeholderImage(),
                    _placeholderImage1(),
                    _placeholderImage2(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// UI للتاب الأول (محتوى الصفحة)
  Widget _tabMainContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),

          /// البانرز
          SizedBox(
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildBannerCard('assets/4t.png'),
                const SizedBox(width: 12),
                _buildBannerCard('assets/1t.png'),
                const SizedBox(width: 12),
                _buildBannerCard('assets/2t.png'),
                const SizedBox(width: 12),
                _buildBannerCard('assets/3t.png'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// الجديد في توكلنا
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                      image: AssetImage('assets/t5.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: MediaQuery.of(context).size.width * 0.98,
                  height: MediaQuery.of(context).size.height * 0.60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('assets/t6.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  /// محتوى placeholder للتاب 2-3-4
  Widget _placeholderImage() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width:
                  MediaQuery.of(context).size.width * 0.98, // 98% من عرض الشاشة
              height: MediaQuery.of(context).size.height *
                  0.50, // 60% من ارتفاع الشاشة
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/0x4.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: MediaQuery.of(context).size.width * 0.98,
              height: MediaQuery.of(context).size.height * 0.40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/0x5.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholderImage1() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width:
                  MediaQuery.of(context).size.width * 0.98, // 98% من عرض الشاشة
              height: MediaQuery.of(context).size.height *
                  0.50, // 60% من ارتفاع الشاشة
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/0x3.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholderImage2() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width:
                  MediaQuery.of(context).size.width * 0.98, // 98% من عرض الشاشة
              height: MediaQuery.of(context).size.height *
                  0.70, // 60% من ارتفاع الشاشة
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/0xxx3.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5F7),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: const [
          Icon(Icons.search, size: 26, color: Colors.black45),
          SizedBox(width: 12),
          Expanded(
            child: Text('ابحث في الخدمات',
                style: TextStyle(fontSize: 18, color: Colors.black54)),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCard(String img) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
      ),
    );
  }
}
