import 'place_category.dart';

class TouristPlace {
  const TouristPlace({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.category,
    required this.city,
    required this.address,
    required this.rating,
    required this.estimatedMinutes,
    required this.isFeatured,
    required this.hasAugmentedReality,
    required this.latitude,
    required this.longitude,
    this.schedule = 'Horario no especificado',
    this.price = 'Acceso libre',
  });

  final String id;
  final String name;
  final String shortDescription;
  final String description;

  final PlaceCategory category;

  final String city;
  final String address;

  final double rating;
  final int estimatedMinutes;

  final bool isFeatured;
  final bool hasAugmentedReality;

  final double latitude;
  final double longitude;

  final String schedule;
  final String price;
}