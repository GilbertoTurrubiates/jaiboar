import 'package:flutter/material.dart';

import '../models/visitor_type.dart';
import '../theme/app_dimensions.dart';
import '../views/home/home_placeholder_view.dart';
import '../views/onboarding/onboarding_view.dart';
import '../views/splash/splash_view.dart';
import '../views/visitor_selection/visitor_selection_view.dart';

abstract final class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String visitorSelection = '/visitor-selection';
  static const String home = '/home';

  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute<void>(
          builder: (_) => const SplashView(),
          settings: settings,
        );

      case onboarding:
        return MaterialPageRoute<void>(
          builder: (_) => const OnboardingView(),
          settings: settings,
        );

      case visitorSelection:
        return MaterialPageRoute<void>(
          builder: (_) => const VisitorSelectionView(),
          settings: settings,
        );

      case home:
        final VisitorType? visitorType =
            settings.arguments is VisitorType
                ? settings.arguments as VisitorType
                : null;

        return MaterialPageRoute<void>(
          builder: (_) => HomePlaceholderView(
            visitorType: visitorType,
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute<void>(
          builder: (_) => UnknownRouteView(
            requestedRoute: settings.name,
          ),
          settings: settings,
        );
    }
  }

  const AppRoutes._();
}

class UnknownRouteView extends StatelessWidget {
  const UnknownRouteView({
    required this.requestedRoute,
    super.key,
  });

  final String? requestedRoute;

  @override
  Widget build(BuildContext context) {
    final String routeName =
        requestedRoute ?? 'desconocida';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ruta no encontrada'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(
              AppDimensions.spacingLarge,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.route_outlined,
                  size: 64,
                  color:
                      Theme.of(context).colorScheme.error,
                ),
                const SizedBox(
                  height: AppDimensions.spacingMedium,
                ),
                Text(
                  'No fue posible abrir esta pantalla.',
                  textAlign: TextAlign.center,
                  style:
                      Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: AppDimensions.spacingSmall,
                ),
                Text(
                  'La ruta solicitada es: $routeName',
                  textAlign: TextAlign.center,
                  style:
                      Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: AppDimensions.spacingLarge,
                ),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(
                      AppRoutes.home,
                      (route) => false,
                    );
                  },
                  icon: const Icon(
                    Icons.home_outlined,
                  ),
                  label: const Text('Ir al inicio'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}