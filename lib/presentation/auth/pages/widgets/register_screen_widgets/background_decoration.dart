import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';

class BackgroundDecoration extends StatelessWidget {
  final Animation<double> pulseAnimation;

  const BackgroundDecoration({super.key, required this.pulseAnimation});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -150,
          right: -150,
          child: AnimatedBuilder(
            animation: pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: pulseAnimation.value,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppPalette.gradientColor
                  ),
                ),
              );
            },
          ),
        ),

        // Bottom-left subtle surface container wave shape
        Positioned(
          bottom: -150,
          left: -80,
          child: Container(
            width: 200,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPalette.gradientColor,
            ),
          ),
        ),
      ],
    );
  }
}