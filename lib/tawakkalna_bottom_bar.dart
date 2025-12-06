import 'package:flutter/material.dart';
import 'MassageScreen.dart';
import 'tawakkalna_screen.dart';
import 'ProfileScreen.dart';
import 'wakib_posts_screen.dart';
import 'ServicesScreen.dart';

class TawakkalnaHome extends StatefulWidget {
  TawakkalnaHome({super.key});

  static final GlobalKey<_TawakkalnaHomeState> globalKey =
      GlobalKey<_TawakkalnaHomeState>();

  @override
  State<TawakkalnaHome> createState() => _TawakkalnaHomeState();
}

class _TawakkalnaHomeState extends State<TawakkalnaHome> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const TawakkalnaScreen(),
    const WakibPostsScreen(),
    const ServicesScreen(),
    MessageScreen(),
    const ProfileScreen(),
  ];

  // الصور عند التحديد
  final List<String> selectedAssets = [
    "assets/fs001.png",
    "assets/n02.png",
    "assets/n03.png",
    "assets/n04.png",
    "assets/n05.png",
  ];

  void changeTab(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: buildTawakkalnaBottomBar(),
    );
  }

  Widget buildTawakkalnaBottomBar() {
    return Container(
      height: 82,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(pages.length, (index) {
          switch (index) {
            case 0:
              return _navItem("توكلنا", "assets/fs002.png", index);
            case 1:
              return _navItem("واكب", "assets/n2.png", index);
            case 2:
              return _navItem("الرسائل", "assets/n3.png", index);
            case 3:
              return _navItem("الخدمات", "assets/n4.png", index);
            case 4:
              return _navItem("معلوماتي", "assets/n5.png", index);
            default:
              return const SizedBox();
          }
        }),
      ),
    );
  }

  Widget _navItem(String title, String asset, int index) {
    bool active = currentIndex == index;

    return GestureDetector(
      onTap: () => _onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            active
                ? selectedAssets[index]
                : asset, // هنا يتم التغيير عند التحديد
            width: 26,
            height: 26,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: active ? Colors.green : Colors.black54,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(int index) {
    setState(() => currentIndex = index);
  }
}
