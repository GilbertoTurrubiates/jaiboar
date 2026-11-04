import 'package:flutter/material.dart';

import '../../models/visitor_type.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';

class ProfilePlaceholderView extends StatelessWidget {
  const ProfilePlaceholderView({
    this.visitorType,
    super.key,
  });

  final VisitorType? visitorType;

  String get _profileName {
    switch (visitorType) {
      case VisitorType.tourist:
        return 'Turista';

      case VisitorType.localResident:
        return 'Habitante local';

      case null:
        return 'Invitado';
    }
  }

  IconData get _profileIcon {
    switch (visitorType) {
      case VisitorType.tourist:
        return Icons.luggage_outlined;

      case VisitorType.localResident:
        return Icons.home_work_outlined;

      case null:
        return Icons.person_outline;
    }
  }

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
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: const BoxDecoration(
                    color: AppColors.lightLagoonGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _profileIcon,
                    size: 54,
                    color: AppColors.lagoonGreen,
                  ),
                ),
                const SizedBox(
                  height: AppDimensions.spacingLarge,
                ),
                Text(
                  'Perfil',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  height: AppDimensions.spacingSmall,
                ),
                Text(
                  'Tipo de visitante: $_profileName',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: AppDimensions.spacingLarge,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      AppDimensions.spacingLarge,
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.settings_outlined,
                          color: AppColors.maritimeBlue,
                          size: 34,
                        ),
                        const SizedBox(
                          height: AppDimensions.spacingMedium,
                        ),
                        Text(
                          'El perfil, las preferencias y la configuración '
                          'se desarrollarán en una fase posterior.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: AppColors.secondaryText,
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