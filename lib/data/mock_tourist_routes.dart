import '../models/tourist_route.dart';

abstract final class MockTouristRoutes {
  static const List<TouristRoute> routes = [
    TouristRoute(
      id: 'tampico_historico',
      name: 'Tampico Histórico',
      description:
          'Recorre algunos de los lugares más representativos '
          'del centro histórico de Tampico.',
      placeIds: [
        'plaza_armas_tampico',
        'plaza_libertad',
        'aduana_tampico',
      ],
      distanceKm: 2.4,
      durationMinutes: 150,
      difficulty: RouteDifficulty.easy,
      transport: RouteTransport.walking,
      isFeatured: true,
    ),
    TouristRoute(
      id: 'miramar_costera',
      name: 'Miramar y Las Escolleras',
      description:
          'Disfruta del paisaje costero de Ciudad Madero '
          'con una visita a Playa Miramar y Las Escolleras.',
      placeIds: [
        'playa_miramar',
        'escolleras_miramar',
      ],
      distanceKm: 3.5,
      durationMinutes: 210,
      difficulty: RouteDifficulty.easy,
      transport: RouteTransport.walking,
      isFeatured: true,
    ),
    TouristRoute(
      id: 'naturaleza_recreacion',
      name: 'Naturaleza y Recreación',
      description:
          'Combina espacios naturales y recreativos de '
          'Tampico y Ciudad Madero.',
      placeIds: [
        'laguna_carpintero',
        'parque_bicentenario',
        'playa_miramar',
      ],
      distanceKm: 14.8,
      durationMinutes: 300,
      difficulty: RouteDifficulty.moderate,
      transport: RouteTransport.car,
      isFeatured: true,
    ),
  ];

  static List<TouristRoute> get featuredRoutes {
    return routes
        .where((route) => route.isFeatured)
        .toList();
  }

  const MockTouristRoutes._();
}