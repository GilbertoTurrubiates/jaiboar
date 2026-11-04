import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    required this.currentPage,
    required this.pageCount,
    super.key,
  });

  final int currentPage;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Página ${currentPage + 1} de $pageCount',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          pageCount,
          (index) {
            final bool isActive = index == currentPage;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: isActive ? 28 : 10,
              height: 10,
              margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingExtraSmall,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.maritimeBlue
                    : AppColors.border,
                borderRadius: BorderRadius.circular(
                  AppDimensions.radiusCircular,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}