import 'package:flutter/material.dart';

import '../../data/mock_tourist_places.dart';
import '../../models/tourist_place.dart';
import '../../models/tourist_route.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../place_detail/place_detail_view.dart';
import 'active_route_view.dart';

class RouteDetailView extends StatelessWidget {
  const RouteDetailView({
    required this.route,
    super.key,
  });

  final TouristRoute route;

  List<TouristPlace> get _places {
    return route.placeIds
        .map(MockTouristPlaces.findById)
        .whereType<TouristPlace>()
        .toList();
  }

  void _openPlace(
    BuildContext context,
    TouristPlace place,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PlaceDetailView(
          place: place,
        ),
      ),
    );
  }

  void _startRoute(
    BuildContext context,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ActiveRouteView(
          route: route,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final places = _places;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalle de ruta',
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(
            AppDimensions.screenHorizontalPadding,
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(
                AppDimensions.spacingLarge,
              ),
              decoration: BoxDecoration(
                color:
                    AppColors.lightLagoonGreen,
                borderRadius:
                    BorderRadius.circular(
                  AppDimensions.radiusLarge,
                ),
              ),
              child: const Icon(
                Icons.route_outlined,
                color: AppColors.lagoonGreen,
                size: 72,
              ),
            ),
            const SizedBox(
              height: AppDimensions.spacingLarge,
            ),
            Text(
              route.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(
              height: AppDimensions.spacingSmall,
            ),
            Text(
              route.description,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                    color: AppColors.secondaryText,
                    height: 1.5,
                  ),
            ),
            const SizedBox(
              height:
                  AppDimensions.spacingExtraLarge,
            ),
            Wrap(
              spacing: AppDimensions.spacingMedium,
              runSpacing:
                  AppDimensions.spacingMedium,
              children: [
                _RouteStat(
                  icon: Icons.straighten,
                  label:
                      '${route.distanceKm.toStringAsFixed(1)} km',
                ),
                _RouteStat(
                  icon: Icons.schedule,
                  label:
                      '${route.durationMinutes} min',
                ),
                _RouteStat(
                  icon: Icons.speed,
                  label: route.difficulty.label,
                ),
                _RouteStat(
                  icon:
                      Icons.directions_outlined,
                  label: route.transport.label,
                ),
              ],
            ),
            const SizedBox(
              height:
                  AppDimensions.spacingExtraLarge,
            ),
            Text(
              'Paradas de la ruta',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: AppDimensions.spacingMedium,
            ),
            ...List.generate(
              places.length,
              (index) {
                final place = places[index];

                return Card(
                  margin: const EdgeInsets.only(
                    bottom:
                        AppDimensions.spacingSmall,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          AppColors.maritimeBlue,
                      foregroundColor:
                          AppColors.white,
                      child: Text(
                        '${index + 1}',
                      ),
                    ),
                    title: Text(
                      place.name,
                    ),
                    subtitle: Text(
                      place.city,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                    ),
                    onTap: () {
                      _openPlace(
                        context,
                        place,
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: AppDimensions.spacingLarge,
            ),
            FilledButton.icon(
              onPressed: places.isEmpty
                  ? null
                  : () {
                      _startRoute(context);
                    },
              icon: const Icon(
                Icons.play_arrow,
              ),
              label: const Text(
                'Iniciar ruta',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RouteStat extends StatelessWidget {
  const _RouteStat({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(
        icon,
        size: 18,
      ),
      label: Text(label),
    );
  }
}