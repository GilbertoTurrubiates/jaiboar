import 'package:flutter/material.dart';

import '../models/onboarding_page_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({
    required this.page,
    required this.pageNumber,
    required this.totalPages,
    super.key,
  });

  final OnboardingPageData page;
  final int pageNumber;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final bool compactScreen = screenSize.height < 650;
    final double illustrationSize = compactScreen ? 190 : 250;

    return Semantics(
      label: page.semanticLabel,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.screenHorizontalPadding,
          vertical: AppDimensions.spacingMedium,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: compactScreen ? 400 : 500,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _OnboardingIllustration(
                page: page,
                size: illustrationSize,
              ),
              SizedBox(
                height: compactScreen
                    ? AppDimensions.spacingLarge
                    : AppDimensions.spacingExtraLarge,
              ),
              Text(
                page.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(
                height: AppDimensions.spacingMedium,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 520,
                ),
                child: Text(
                  page.description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.secondaryText,
                        height: 1.55,
                      ),
                ),
              ),
              const SizedBox(
                height: AppDimensions.spacingLarge,
              ),
              Text(
                '$pageNumber de $totalPages',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.secondaryText,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingIllustration extends StatelessWidget {
  const _OnboardingIllustration({
    required this.page,
    required this.size,
  });

  final OnboardingPageData page;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: size * 0.06,
              right: size * 0.03,
              child: Container(
                width: size * 0.28,
                height: size * 0.28,
                decoration: BoxDecoration(
                  color: AppColors.lightSandOrange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: size * 0.03,
              left: size * 0.02,
              child: Container(
                width: size * 0.36,
                height: size * 0.36,
                decoration: BoxDecoration(
                  color: AppColors.lightLagoonGreen,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Container(
              width: size * 0.76,
              height: size * 0.76,
              decoration: BoxDecoration(
                color: page.backgroundColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white,
                  width: 8,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.border,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                page.icon,
                size: size * 0.34,
                color: page.primaryColor,
              ),
            ),
            Positioned(
              right: size * 0.07,
              bottom: size * 0.13,
              child: Container(
                width: size * 0.23,
                height: size * 0.23,
                decoration: const BoxDecoration(
                  color: AppColors.sandOrange,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  size: size * 0.12,
                  color: AppColors.darkMaritimeBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}