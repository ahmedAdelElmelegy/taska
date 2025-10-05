import 'package:flutter/material.dart';

class CustomLoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool? isLoading;

  const CustomLoadingOverlay({
    super.key,
    this.isLoading = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // محتوى الصفحة الأساسي
        child,

        // شرط عرض التحميل الرمادي والـ loader
        if (isLoading == true)
          Positioned.fill(
            child: Container(
              color: Colors.grey.withOpacity(0.5), // خلفية رمادية شفافة
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
