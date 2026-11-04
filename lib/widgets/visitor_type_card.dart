import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class VisitorTypeCard extends StatelessWidget {
  const VisitorTypeCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });

  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isSelected
        ? AppColors.lagoonGreen
        : AppColors.border;

    final Color backgroundColor = isSelected
        ? AppColors.lightLagoonGreen
        : AppColors.white;

    return Semantics(
      button: true,
      selected: isSelected,
      label: '$title. $description',
      hint: isSelected
          ? 'Opción seleccionada'
          : 'Toca dos veces para seleccionar',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusLarge,
          ),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkMaritimeBlue.withOpacity(
                isSelected ? 0.10 : 0.05,
              ),
              blurRadius: isSelected ? 16 : 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusLarge,
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusLarge,
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                AppDimensions.spacingLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _VisitorIcon(
                        icon: icon,
                        isSelected: isSelected,
                      ),
                      const Spacer(),
                      _SelectionIndicator(
                        isSelected: isSelected,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppDimensions.spacingLarge,
                  ),
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          color: AppColors.secondaryText,
                          height: 1.5,
                        ),
                  ),
                  const SizedBox(
                    height: AppDimensions.spacingMedium,
                  ),
                  Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.check_circle
                            : Icons.touch_app_outlined,
                        color: isSelected
                            ? AppColors.lagoonGreen
                            : AppColors.secondaryText,
                        size: AppDimensions.iconSmall,
                      ),
                      const SizedBox(
                        width: AppDimensions.spacingSmall,
                      ),
                      Expanded(
                        child: Text(
                          isSelected
                              ? 'Perfil seleccionado'
                              : 'Seleccionar este perfil',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color: isSelected
                                    ? AppColors.darkLagoonGreen
                                    : AppColors.secondaryText,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VisitorIcon extends StatelessWidget {
  const _VisitorIcon({
    required this.icon,
    required this.isSelected,
  });

  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.lagoonGreen
            : AppColors.lightMaritimeBlue,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMedium,
        ),
      ),
      child: Icon(
        icon,
        size: 34,
        color: isSelected
            ? AppColors.white
            : AppColors.maritimeBlue,
      ),
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator({
    required this.isSelected,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.lagoonGreen
            : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? AppColors.lagoonGreen
              : AppColors.border,
          width: 2,
        ),
      ),
      child: isSelected
          ? const Icon(
              Icons.check,
              color: AppColors.white,
              size: 20,
            )
          : null,
    );
  }
}