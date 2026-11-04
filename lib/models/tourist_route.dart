enum RouteDifficulty {
  easy,
  moderate,
  demanding,
}

extension RouteDifficultyExtension
    on RouteDifficulty {
  String get label {
    switch (this) {
      case RouteDifficulty.easy:
        return 'Fácil';
      case RouteDifficulty.moderate:
        return 'Moderada';
      case RouteDifficulty.demanding:
        return 'Exigente';
    }
  }
}

enum RouteTransport {
  walking,
  car,
  mixed,
}

extension RouteTransportExtension
    on RouteTransport {
  String get label {
    switch (this) {
      case RouteTransport.walking:
        return 'A pie';
      case RouteTransport.car:
        return 'Automóvil';
      case RouteTransport.mixed:
        return 'Mixto';
    }
  }
}

class TouristRoute {
  const TouristRoute({
    required this.id,
    required this.name,
    required this.description,
    required this.placeIds,
    required this.distanceKm,
    required this.durationMinutes,
    required this.difficulty,
    required this.transport,
    required this.isFeatured,
  });

  final String id;
  final String name;
  final String description;

  final List<String> placeIds;

  final double distanceKm;
  final int durationMinutes;

  final RouteDifficulty difficulty;
  final RouteTransport transport;

  final bool isFeatured;
}