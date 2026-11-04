import 'package:flutter/material.dart';

import '../../data/mock_tourist_routes.dart';
import '../../models/tourist_route.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../widgets/tourist_route_card.dart';
import 'route_detail_view.dart';

class RoutesView extends StatelessWidget {
  const RoutesView({super.key});

  void _openRoute(
    BuildContext context,
    TouristRoute route,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => RouteDetailView(
          route: route,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routes = MockTouristRoutes.routes;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rutas turísticas',
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(
            AppDimensions.screenHorizontalPadding,
          ),
          itemCount: routes.length,
          separatorBuilder: (_, _) =>
              const SizedBox(
            height: AppDimensions.spacingMedium,
          ),
          itemBuilder: (context, index) {
            final route = routes[index];

            return TouristRouteCard(
              route: route,
              onPressed: () {
                _openRoute(
                  context,
                  route,
                );
              },
            );
          },
        ),
      ),
    );
  }
}