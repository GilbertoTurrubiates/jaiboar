enum ArSimulationState { searching, recognized, notRecognized, outOfRange }

class ArExperience {
  const ArExperience({
    required this.id,
    required this.placeId,
    required this.placeName,
    required this.title,
    required this.description,
    required this.historicalFact,
  });

  final String id;
  final String placeId;
  final String placeName;
  final String title;
  final String description;
  final String historicalFact;
}
