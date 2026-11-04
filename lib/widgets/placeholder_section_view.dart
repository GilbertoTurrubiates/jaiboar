import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class PlaceholderSectionView extends StatelessWidget {
  const PlaceholderSectionView({
    required this.title,
    required this.description,
    required this.icon,
    required this.pendingMessage,
    this.iconColor = AppColors.maritimeBlue,
    this.iconBackgroundColor = AppColors.lightMaritimeBlue,
    super.key,
  });

  final String title;
  final String description;
  final IconData icon;
  final String pendingMessage;
  final Color iconColor;
  final Color iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.screenHorizontalPadding,
            vertical: AppDimensions.screenVerticalPadding,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppDimensions.contentMaxWidth,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: iconBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 54,
                    color: iconColor,
                  ),
                ),
                const SizedBox(
                  height: AppDimensions.spacingLarge,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  height: AppDimensions.spacingSmall,
                ),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(
                        color: AppColors.secondaryText,
                        height: 1.5,
                      ),
                ),
                const SizedBox(
                  height: AppDimensions.spacingLarge,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      AppDimensions.spacingLarge,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: AppColors.lagoonGreen,
                        ),
                        const SizedBox(
                          width: AppDimensions.spacingMedium,
                        ),
                        Expanded(
                          child: Text(
                            pendingMessage,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.secondaryText,
                                  height: 1.5,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}