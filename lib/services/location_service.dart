import 'package:geolocator/geolocator.dart';

enum LocationRequestStatus {
  success,
  serviceDisabled,
  permissionDenied,
  permissionDeniedForever,
  unavailable,
}

class LocationRequestResult {
  const LocationRequestResult({
    required this.status,
    this.position,
  });

  final LocationRequestStatus status;
  final Position? position;

  bool get isSuccess =>
      status == LocationRequestStatus.success &&
      position != null;
}

class LocationService {
  const LocationService();

  Future<LocationRequestResult> getCurrentLocation() async {
    try {
      final bool serviceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        return const LocationRequestResult(
          status: LocationRequestStatus.serviceDisabled,
        );
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission =
            await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          return const LocationRequestResult(
            status: LocationRequestStatus.permissionDenied,
          );
        }
      }

      if (permission ==
          LocationPermission.deniedForever) {
        return const LocationRequestResult(
          status:
              LocationRequestStatus.permissionDeniedForever,
        );
      }

      final Position position =
          await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      return LocationRequestResult(
        status: LocationRequestStatus.success,
        position: position,
      );
    } catch (_) {
      return const LocationRequestResult(
        status: LocationRequestStatus.unavailable,
      );
    }
  }

  Future<bool> openAppSettings() {
    return Geolocator.openAppSettings();
  }

  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }

  double distanceBetween({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }
}