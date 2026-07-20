import 'dart:ui';
import 'package:flutter/material.dart';

class ToggleBlurCard extends StatefulWidget {
  final String imagePath;
  final VoidCallback onTap;
  final double width;
  final double height;
  final double blurSigma;
  final double overlayOpacity;

  const ToggleBlurCard({
    super.key,
    required this.imagePath,
    required this.onTap,
    this.width = 150,
    this.height = 100,
    this.blurSigma = 4.5, // قريب من الصورة
    this.overlayOpacity = 0.03,
  });

  @override
  State<ToggleBlurCard> createState() => _ToggleBlurCardState();
}

class _ToggleBlurCardState extends State<ToggleBlurCard> {
  bool isBlurred = false;

  void _toggleBlur() {
    setState(() => isBlurred = !isBlurred);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: _toggleBlur,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // الصورة نفسها
              ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: isBlurred ? widget.blurSigma : 0,
                  sigmaY: isBlurred ? widget.blurSigma : 0,
                ),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.image, color: Colors.grey),
                    ),
                  ),
                ),
              ),

              // طبقة خفيفة فوق الصورة مثل الضباب
              if (isBlurred)
                Container(
                  color: Colors.white.withOpacity(widget.overlayOpacity),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
/*// في أعلى الملف
import 'dart:ui';
import 'package:flutter/material.dart';

// استبدال _cardButton بـ ToggleBlurCard
class ToggleBlurCard extends StatefulWidget {
  final String imagePath;
  final VoidCallback onTap;
  final double width;
  final double height;
  final double blurSigma;
  final double overlayOpacity; // إضافي: عتمة فوق البلور

  const ToggleBlurCard({
    super.key,
    required this.imagePath,
    required this.onTap,
    this.width = 150,
    this.height = 100,
    this.blurSigma = 8,
    this.overlayOpacity = 0.05,
  });

  @override
  State<ToggleBlurCard> createState() => _ToggleBlurCardState();
}

class _ToggleBlurCardState extends State<ToggleBlurCard> {
  bool isBlurred = false;

  void _toggleBlur() {
    setState(() => isBlurred = !isBlurred);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: _toggleBlur,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // الصورة الأساسية
              Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  color: Colors.grey.shade200,
                  child: const Center(
                    child: Icon(Icons.image, color: Colors.grey),
                  ),
                ),
              ),

              // BackdropFilter يجب أن يكون داخل ClipRect ليعمل.
              // نستخدم Positioned.fill + ClipRect + BackdropFilter + Container overlay
              if (isBlurred)
                Positioned.fill(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: widget.blurSigma,
                        sigmaY: widget.blurSigma,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        color: Colors.black.withOpacity(widget.overlayOpacity),
                      ),
                    ),
                  ),
                ),

              // اختياري: أيقونة تظهر حال وجود الضبابية (يمكن حذفها)
              // Positioned(
              //   top: 6,
              //   left: 6,
              //   child: isBlurred ? Icon(Icons.visibility_off, color: Colors.white70) : SizedBox.shrink(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
*/