import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/tourist_place.dart';

class MapService {
  const MapService();

  static const CameraPosition initialCameraPosition =
      CameraPosition(
    target: LatLng(
      22.2331,
      -97.8611,
    ),
    zoom: 12.5,
  );

  Set<Marker> buildTouristPlaceMarkers({
    required List<TouristPlace> places,
    required ValueChanged<TouristPlace> onSelected,
  }) {
    return places.map((place) {
      return Marker(
        markerId: MarkerId(place.id),
        position: LatLng(
          place.latitude,
          place.longitude,
        ),
        infoWindow: InfoWindow(
          title: place.name,
          snippet: place.city,
        ),
        onTap: () {
          onSelected(place);
        },
      );
    }).toSet();
  }
}