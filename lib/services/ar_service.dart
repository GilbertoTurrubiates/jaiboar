import '../data/mock_ar_experiences.dart';
import '../models/ar_experience.dart';

/// Contrato listo para sustituir el simulador por un proveedor real en fase 17.
abstract class ArService {
  const ArService();

  Future<List<ArExperience>> getExperiences();
  Future<ArExperience?> getExperienceForPlace(String placeId);
}

class MockArService extends ArService {
  const MockArService();

  @override
  Future<List<ArExperience>> getExperiences() async =>
      MockArExperiences.experiences;

  @override
  Future<ArExperience?> getExperienceForPlace(String placeId) async {
    for (final experience in MockArExperiences.experiences) {
      if (experience.placeId == placeId) return experience;
    }
    return null;
  }
}
