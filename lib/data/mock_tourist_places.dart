import '../models/place_category.dart';
import '../models/tourist_place.dart';

abstract final class MockTouristPlaces {
  static const List<TouristPlace> places = [
    TouristPlace(
      id: 'plaza_armas_tampico',
      name: 'Plaza de Armas de Tampico',
      shortDescription:
          'Uno de los espacios más representativos del centro histórico.',
      description:
          'La Plaza de Armas forma parte del corazón histórico de Tampico. '
          'Es un punto de referencia para conocer la arquitectura, la '
          'historia y la vida urbana de la ciudad.',
      category: PlaceCategory.historical,
      city: 'Tampico',
      address: 'Centro Histórico de Tampico',
      rating: 4.8,
      estimatedMinutes: 45,
      isFeatured: true,
      hasAugmentedReality: true,
      latitude: 22.2150,
      longitude: -97.8570,
      schedule: 'Espacio público',
      price: 'Acceso libre',
    ),
    TouristPlace(
      id: 'aduana_tampico',
      name: 'Antigua Aduana Marítima',
      shortDescription:
          'Edificio emblemático relacionado con la historia portuaria.',
      description:
          'La Antigua Aduana Marítima es uno de los edificios históricos '
          'más reconocidos de Tampico y está relacionada con el desarrollo '
          'comercial y portuario de la región.',
      category: PlaceCategory.historical,
      city: 'Tampico',
      address: 'Zona Centro, Tampico',
      rating: 4.9,
      estimatedMinutes: 60,
      isFeatured: true,
      hasAugmentedReality: true,
      latitude: 22.2137,
      longitude: -97.8610,
      schedule: 'Consultar disponibilidad',
      price: 'Consultar acceso',
    ),
    TouristPlace(
      id: 'laguna_carpintero',
      name: 'Laguna del Carpintero',
      shortDescription:
          'Espacio natural y recreativo ubicado dentro de Tampico.',
      description:
          'La Laguna del Carpintero es uno de los espacios naturales '
          'más conocidos de Tampico y permite realizar recorridos y '
          'actividades recreativas.',
      category: PlaceCategory.natural,
      city: 'Tampico',
      address: 'Laguna del Carpintero, Tampico',
      rating: 4.7,
      estimatedMinutes: 90,
      isFeatured: true,
      hasAugmentedReality: false,
      latitude: 22.2290,
      longitude: -97.8610,
      schedule: 'Espacio público',
      price: 'Acceso libre',
    ),
    TouristPlace(
      id: 'plaza_libertad',
      name: 'Plaza de la Libertad',
      shortDescription:
          'Plaza rodeada por arquitectura característica de Tampico.',
      description:
          'La Plaza de la Libertad forma parte del patrimonio urbano '
          'del centro de Tampico y está rodeada por edificios de '
          'importancia histórica y arquitectónica.',
      category: PlaceCategory.cultural,
      city: 'Tampico',
      address: 'Centro Histórico de Tampico',
      rating: 4.7,
      estimatedMinutes: 40,
      isFeatured: false,
      hasAugmentedReality: true,
      latitude: 22.2160,
      longitude: -97.8590,
      schedule: 'Espacio público',
      price: 'Acceso libre',
    ),
    TouristPlace(
      id: 'playa_miramar',
      name: 'Playa Miramar',
      shortDescription:
          'Uno de los principales atractivos turísticos de Ciudad Madero.',
      description:
          'Playa Miramar es uno de los destinos recreativos y naturales '
          'más importantes de la zona sur de Tamaulipas.',
      category: PlaceCategory.natural,
      city: 'Ciudad Madero',
      address: 'Playa Miramar, Ciudad Madero',
      rating: 4.9,
      estimatedMinutes: 180,
      isFeatured: true,
      hasAugmentedReality: false,
      latitude: 22.2760,
      longitude: -97.8030,
      schedule: 'Espacio público',
      price: 'Acceso libre',
    ),
    TouristPlace(
      id: 'escolleras_miramar',
      name: 'Escolleras de Miramar',
      shortDescription:
          'Recorrido junto al mar con vistas hacia la entrada del puerto.',
      description:
          'Las Escolleras ofrecen un recorrido recreativo junto al Golfo '
          'de México y constituyen uno de los lugares más visitados '
          'de Miramar.',
      category: PlaceCategory.recreational,
      city: 'Ciudad Madero',
      address: 'Playa Miramar, Ciudad Madero',
      rating: 4.8,
      estimatedMinutes: 75,
      isFeatured: true,
      hasAugmentedReality: false,
      latitude: 22.2680,
      longitude: -97.7900,
      schedule: 'Espacio público',
      price: 'Acceso libre',
    ),
    TouristPlace(
      id: 'parque_bicentenario',
      name: 'Parque Bicentenario',
      shortDescription:
          'Espacio recreativo para actividades familiares y al aire libre.',
      description:
          'El Parque Bicentenario ofrece espacios destinados a la '
          'recreación, convivencia y actividades al aire libre.',
      category: PlaceCategory.recreational,
      city: 'Ciudad Madero',
      address: 'Ciudad Madero, Tamaulipas',
      rating: 4.5,
      estimatedMinutes: 90,
      isFeatured: false,
      hasAugmentedReality: false,
      latitude: 22.2800,
      longitude: -97.8300,
      schedule: 'Consultar horario',
      price: 'Acceso libre',
    ),
    TouristPlace(
      id: 'casa_cultura_tampico',
      name: 'Casa de la Cultura de Tampico',
      shortDescription:
          'Espacio dedicado a actividades artísticas y culturales.',
      description:
          'La Casa de la Cultura es un espacio destinado a promover '
          'actividades artísticas y culturales de la región.',
      category: PlaceCategory.cultural,
      city: 'Tampico',
      address: 'Tampico, Tamaulipas',
      rating: 4.6,
      estimatedMinutes: 60,
      isFeatured: false,
      hasAugmentedReality: false,
      latitude: 22.2300,
      longitude: -97.8600,
      schedule: 'Consultar horario',
      price: 'Consultar acceso',
    ),
  ];

  static List<TouristPlace> get featuredPlaces {
    return places.where((place) => place.isFeatured).toList();
  }

  static List<TouristPlace> byCategory(
    PlaceCategory category,
  ) {
    return places
        .where((place) => place.category == category)
        .toList();
  }

  static TouristPlace? findById(String id) {
    for (final place in places) {
      if (place.id == id) {
        return place;
      }
    }

    return null;
  }

  const MockTouristPlaces._();
}