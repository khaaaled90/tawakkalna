//import 'dart:js';

import 'package:flutter/material.dart';

class PassportDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'تفاصيل الجواز',
          style: TextStyle(color: Colors.white, fontSize: 35),
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
      //body: SafeArea(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //const SizedBox(height: 5),
              _circleButton(context, "assets/Jw3.png"),
              const SizedBox(height: 20),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _circleButton(context, "assets/Jw3.png"),
                ],
              ),*/
              // صورة المستخدم
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/avatar.png'), // ضع الصورة الافتراضية هنا
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 4),
              _item('الاسم', 'رائد بن محمد بن إبراهيم إبراهيم'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('الجنسية', 'المملكة العربية السعودية'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('رقم جواز السفر', 'V872997'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('الجنس', 'ذكر'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('نوع الجواز', 'عادي'),
              Container(height: 1, color: Colors.white24),
              _item('تاريخ الميلاد', '1412/10/14'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('مكان الإصدار', 'جدة'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
              _item('تاريخ الاصدار', '1441/11/21'),
              Container(height: 1, color: Colors.white24),
              const SizedBox(height: 4),
            ],
          ),
        ),
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
              Text(title,
                  style: const TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
              //const SizedBox(height: 8),
            ],
          )
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

  Widget _circleButton(BuildContext context, String imagePath) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.16,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Image.asset(imagePath, fit: BoxFit.fill),
      ),
    );
  }
}
