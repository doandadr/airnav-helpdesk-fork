import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Widget loading dengan animasi Lottie
///
/// Bisa digunakan untuk menampilkan loading indicator
/// menggunakan animasi Lottie yang lebih menarik
class LottieLoadingWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String? customAnimationPath;

  const LottieLoadingWidget({
    super.key,
    this.width = 150,
    this.height = 150,
    this.customAnimationPath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        customAnimationPath ?? 'assets/animations/flightn.json',
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}

/// Widget loading dengan overlay
///
/// Menampilkan loading di atas konten dengan background semi-transparan
class LottieLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final String? customAnimationPath;

  const LottieLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.width = 150,
    this.height = 150,
    this.backgroundColor,
    this.customAnimationPath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: backgroundColor ?? Colors.black.withOpacity(0.5),
            child: LottieLoadingWidget(
              width: width,
              height: height,
              customAnimationPath: customAnimationPath,
            ),
          ),
      ],
    );
  }
}
