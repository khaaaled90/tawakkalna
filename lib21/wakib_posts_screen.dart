import 'package:flutter/material.dart';

class WakibPostsScreen extends StatefulWidget {
  const WakibPostsScreen({super.key});

  @override
  State<WakibPostsScreen> createState() => _WakibPostsScreenState();
}

class _WakibPostsScreenState extends State<WakibPostsScreen> {
  int selectedTab = 0;

  final List<String> tabTitles = [
    'كل المنشورات',
    'المتابعون',
  ];

  final List<String> allPostsImages =
      List.generate(7, (i) => 'assets/msh${i + 1}.png');

  final List<String> followersImages =
      List.generate(7, (i) => 'assets/msh${i + 1}.png');

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // العنوان
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: Text(
                        'آخر المنشورات',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.bookmark_border, size: 28),
                  ],
                ),
              ),

              // البحث
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, color: Colors.black54),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text("ابحث في توكلنا",
                            style: TextStyle(color: Colors.black54)),
                      ),
                    ],
                  ),
                ),
              ),

              // تبويبات نصوص بمحاذاة لليمين وخط كامل تحت النص
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(tabTitles.length, (index) {
                    final active = selectedTab == index;

                    // ـــ قياس عرض النص ـــ
                    final tp = TextPainter(
                      text: TextSpan(
                        text: tabTitles[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              active ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      textDirection: TextDirection.rtl,
                    )..layout();

                    final textWidth = tp.width;

                    return GestureDetector(
                      onTap: () => setState(() => selectedTab = index),
                      child: Container(
                        margin: const EdgeInsets.only(left: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // النص
                            Text(
                              tabTitles[index],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: active
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: active ? Colors.blue : Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // الخط بالضبط أسفل النص وبنفس عرضه
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              width: active ? textWidth : 0,
                              height: 3,
                              decoration: BoxDecoration(
                                color:
                                    active ? Colors.blue : Colors.transparent,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),

              Divider(height: 1),

              // محتوى التابات مع Scroll مستقل لكل تبويب (IndexedStack)
              Expanded(
                child: IndexedStack(
                  index: selectedTab,
                  children: [
                    buildImageList(allPostsImages),
                    buildImageList(followersImages),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // قائمة صور مع Scroll مستقل
  Widget buildImageList(List<String> images) {
    return SingleChildScrollView(
      child: Column(
        children: images
            .map(
              (path) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    path,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
