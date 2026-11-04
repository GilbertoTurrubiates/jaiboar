import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  static const int homeIndex = 0;
  static const int exploreIndex = 1;
  static const int mapIndex = 2;
  static const int arIndex = 3;
  static const int profileIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 8,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 76,
          child: Row(
            children: [
              Expanded(
                child: _NavigationItem(
                  label: 'Inicio',
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  index: homeIndex,
                  currentIndex: currentIndex,
                  onPressed: onDestinationSelected,
                ),
              ),
              Expanded(
                child: _NavigationItem(
                  label: 'Explorar',
                  icon: Icons.explore_outlined,
                  selectedIcon: Icons.explore,
                  index: exploreIndex,
                  currentIndex: currentIndex,
                  onPressed: onDestinationSelected,
                ),
              ),
              Expanded(
                child: _NavigationItem(
                  label: 'Mapa',
                  icon: Icons.map_outlined,
                  selectedIcon: Icons.map,
                  index: mapIndex,
                  currentIndex: currentIndex,
                  onPressed: onDestinationSelected,
                ),
              ),
              Expanded(
                child: _ArNavigationItem(
                  isSelected: currentIndex == arIndex,
                  onPressed: () {
                    onDestinationSelected(arIndex);
                  },
                ),
              ),
              Expanded(
                child: _NavigationItem(
                  label: 'Perfil',
                  icon: Icons.person_outline,
                  selectedIcon: Icons.person,
                  index: profileIndex,
                  currentIndex: currentIndex,
                  onPressed: onDestinationSelected,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.index,
    required this.currentIndex,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onPressed;

  bool get isSelected => index == currentIndex;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        onTap: () {
          onPressed(index);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.spacingSmall,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.lightLagoonGreen
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusCircular,
                  ),
                ),
                child: Icon(
                  isSelected ? selectedIcon : icon,
                  color: isSelected
                      ? AppColors.lagoonGreen
                      : AppColors.secondaryText,
                  size: AppDimensions.iconMedium,
                ),
              ),
              const SizedBox(
                height: AppDimensions.spacingExtraSmall,
              ),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isSelected
                          ? AppColors.darkLagoonGreen
                          : AppColors.secondaryText,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArNavigationItem extends StatelessWidget {
  const _ArNavigationItem({
    required this.isSelected,
    required this.onPressed,
  });

  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Cámara RA',
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.spacingExtraSmall,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isSelected ? 46 : 42,
                height: isSelected ? 46 : 42,
                decoration: BoxDecoration(
                  color: AppColors.sandOrange,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.darkSandOrange
                        : AppColors.lightSandOrange,
                    width: isSelected ? 3 : 2,
                  ),
                ),
                child: const Icon(
                  Icons.view_in_ar_outlined,
                  color: AppColors.darkMaritimeBlue,
                  size: 25,
                ),
              ),
              const SizedBox(
                height: AppDimensions.spacingExtraSmall,
              ),
              Text(
                'Cámara RA',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isSelected
                          ? AppColors.darkSandOrange
                          : AppColors.secondaryText,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}