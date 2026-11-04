import 'package:flutter/material.dart';

import '../models/tourist_route.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class TouristRouteCard extends StatelessWidget {
  const TouristRouteCard({
    required this.route,
    required this.onPressed,
    super.key,
  });

  final TouristRoute route;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(
            AppDimensions.spacingLarge,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: const BoxDecoration(
                      color:
                          AppColors.lightLagoonGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.route_outlined,
                      color: AppColors.lagoonGreen,
                      size: 28,
                    ),
                  ),
                  const SizedBox(
                    width:
                        AppDimensions.spacingMedium,
                  ),
                  Expanded(
                    child: Text(
                      route.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                            fontWeight:
                                FontWeight.w700,
                          ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                  ),
                ],
              ),
              const SizedBox(
                height: AppDimensions.spacingMedium,
              ),
              Text(
                route.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                      color:
                          AppColors.secondaryText,
                      height: 1.5,
                    ),
              ),
              const SizedBox(
                height: AppDimensions.spacingMedium,
              ),
              Wrap(
                spacing: AppDimensions.spacingLarge,
                runSpacing:
                    AppDimensions.spacingSmall,
                children: [
                  _RouteInfo(
                    icon:
                        Icons.location_on_outlined,
                    text:
                        '${route.placeIds.length} paradas',
                  ),
                  _RouteInfo(
                    icon: Icons.straighten,
                    text:
                        '${route.distanceKm.toStringAsFixed(1)} km',
                  ),
                  _RouteInfo(
                    icon: Icons.schedule_outlined,
                    text:
                        '${route.durationMinutes} min',
                  ),
                  _RouteInfo(
                    icon:
                        Icons.directions_walk_outlined,
                    text:
                        route.transport.label,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RouteInfo extends StatelessWidget {
  const _RouteInfo({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 17,
          color: AppColors.sandOrange,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style:
              Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}