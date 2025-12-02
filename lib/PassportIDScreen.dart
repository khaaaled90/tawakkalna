// =============================
// شاشة الهوية الوطنية (National ID Screen)
// =============================

import 'package:flutter/material.dart';

class PassportIDScreen extends StatelessWidget {
  const PassportIDScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              const SizedBox(height: 12),
              _buildInfoCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 240,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/header_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 240,
          color: Colors.black.withOpacity(0.25),
        ),
        Positioned(
          top: 48,
          right: 16,
          left: 16,
          child: Row(
            children: [
              const Text(
                'معلوماتي',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 6, color: Colors.black45)],
                ),
              ),
              const Spacer(),
              _circleAction(Icons.edit),
              const SizedBox(width: 10),
              _circleAction(Icons.settings),
            ],
          ),
        ),
        Positioned(
          top: 150,
          left: 22,
          right: 22,
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, spreadRadius: 1),
              ],
            ),
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                Expanded(
                  child: Text('ابحث في معلوماتي',
                      style: TextStyle(color: Colors.black54, fontSize: 16)),
                ),
                Icon(Icons.search, color: Colors.black54),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 22,
          child: Container(
            width: 95,
            height: 95,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 5),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
              image: const DecorationImage(
                image: AssetImage('assets/avatar.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الهوية الوطنية',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statItem('المملكة العربية السعودية', Icons.flag),
              _statItem('1992-04-17', Icons.calendar_today),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _statItem('1992-04-17', Icons.calendar_today),
              const SizedBox(width: 12),
              _statItem('+0', Icons.opacity),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(String text, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.green, size: 18),
        ),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 14, color: Colors.black87)),
      ],
    );
  }

  Widget _circleAction(IconData icon) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Icon(icon, color: Colors.black87, size: 20),
    );
  }
}
