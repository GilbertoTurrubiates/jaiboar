import '../models/ar_experience.dart';

abstract final class MockArExperiences {
  static const List<ArExperience> experiences = [
    ArExperience(
      id: 'ar_plaza_armas',
      placeId: 'plaza_armas_tampico',
      placeName: 'Plaza de Armas de Tampico',
      title: 'Historia de la Plaza de Armas',
      description: 'Explora una ficha histórica superpuesta de manera simulada.',
      historicalFact: 'La Plaza de Armas forma parte del centro histórico de Tampico.',
    ),
    ArExperience(
      id: 'ar_aduana',
      placeId: 'aduana_tampico',
      placeName: 'Antigua Aduana Marítima',
      title: 'Memoria del puerto',
      description: 'Conoce la importancia histórica del edificio portuario.',
      historicalFact: 'La Antigua Aduana Marítima está vinculada al desarrollo comercial y portuario de Tampico.',
    ),
    ArExperience(
      id: 'ar_plaza_libertad',
      placeId: 'plaza_libertad',
      placeName: 'Plaza de la Libertad',
      title: 'Arquitectura del centro',
      description: 'Descubre la historia arquitectónica en una superposición simulada.',
      historicalFact: 'La Plaza de la Libertad está rodeada por edificios representativos del centro de Tampico.',
    ),
  ];
}
