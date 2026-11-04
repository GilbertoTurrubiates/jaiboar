import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/mock_tourist_places.dart';
import '../../models/tourist_place.dart';
import '../../models/tourist_route.dart';
import '../../services/location_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';

class ActiveRouteView extends StatefulWidget {
  const ActiveRouteView({
    required this.route,
    super.key,
  });

  final TouristRoute route;

  @override
  State<ActiveRouteView> createState() =>
      _ActiveRouteViewState();
}

class _ActiveRouteViewState
    extends State<ActiveRouteView> {
  final LocationService _locationService =
      const LocationService();

  GoogleMapController? _mapController;

  Position? _currentPosition;

  int _currentStopIndex = 0;

  final Set<String> _completedPlaceIds = {};

  bool _loadingLocation = false;

  List<TouristPlace> get _places {
    return widget.route.placeIds
        .map(MockTouristPlaces.findById)
        .whereType<TouristPlace>()
        .toList();
  }

  TouristPlace? get _currentPlace {
    final places = _places;

    if (places.isEmpty ||
        _currentStopIndex >= places.length) {
      return null;
    }

    return places[_currentStopIndex];
  }

  bool get _routeCompleted {
    final places = _places;

    return places.isNotEmpty &&
        _completedPlaceIds.length ==
            places.length;
  }

  double get _progress {
    final places = _places;

    if (places.isEmpty) {
      return 0;
    }

    return _completedPlaceIds.length /
        places.length;
  }

  Set<Marker> get _markers {
    return _places.asMap().entries.map(
      (entry) {
        final int index = entry.key;
        final TouristPlace place =
            entry.value;

        final bool completed =
            _completedPlaceIds
                .contains(place.id);

        return Marker(
          markerId: MarkerId(
            'route_${place.id}',
          ),
          position: LatLng(
            place.latitude,
            place.longitude,
          ),
          infoWindow: InfoWindow(
            title:
                '${index + 1}. ${place.name}',
            snippet: completed
                ? 'Visitado'
                : 'Pendiente',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            completed
                ? BitmapDescriptor.hueGreen
                : index == _currentStopIndex
                    ? BitmapDescriptor.hueOrange
                    : BitmapDescriptor.hueRed,
          ),
        );
      },
    ).toSet();
  }

  Set<Polyline> get _polylines {
    final List<LatLng> points =
        _places.map((place) {
      return LatLng(
        place.latitude,
        place.longitude,
      );
    }).toList();

    if (points.length < 2) {
      return {};
    }

    return {
      Polyline(
        polylineId:
            const PolylineId('active-route'),
        points: points,
        width: 5,
        color: AppColors.maritimeBlue,
        geodesic: true,
      ),
    };
  }

  @override
  void initState() {
    super.initState();

    _loadLocation();
  }

  Future<void> _loadLocation() async {
    if (_loadingLocation) {
      return;
    }

    setState(() {
      _loadingLocation = true;
    });

    final result =
        await _locationService
            .getCurrentLocation();

    if (!mounted) {
      return;
    }

    if (result.isSuccess) {
      setState(() {
        _currentPosition =
            result.position;
      });
    }

    setState(() {
      _loadingLocation = false;
    });
  }

  void _onMapCreated(
    GoogleMapController controller,
  ) {
    _mapController = controller;

    _focusCurrentStop();
  }

  Future<void> _focusCurrentStop() async {
    final place = _currentPlace;
    final controller = _mapController;

    if (place == null ||
        controller == null) {
      return;
    }

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            place.latitude,
            place.longitude,
          ),
          zoom: 15,
        ),
      ),
    );
  }

  void _markCurrentStopVisited() {
    final place = _currentPlace;

    if (place == null) {
      return;
    }

    setState(() {
      _completedPlaceIds.add(place.id);

      if (_currentStopIndex <
          _places.length - 1) {
        _currentStopIndex++;
      }
    });

    _focusCurrentStop();
  }

  void _finishRoute() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Ruta completada',
          ),
          content: Text(
            'Has completado la ruta '
            '"${widget.route.name}".',
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext)
                    .pop();

                Navigator.of(context).pop();
              },
              child: const Text(
                'Finalizar',
              ),
            ),
          ],
        );
      },
    );
  }

  String _distanceToCurrentPlace() {
    final place = _currentPlace;
    final position = _currentPosition;

    if (place == null ||
        position == null) {
      return 'Distancia no disponible';
    }

    final double meters =
        _locationService.distanceBetween(
      startLatitude: position.latitude,
      startLongitude: position.longitude,
      endLatitude: place.latitude,
      endLongitude: place.longitude,
    );

    if (meters < 1000) {
      return '${meters.round()} m';
    }

    return '${(meters / 1000).toStringAsFixed(1)} km';
  }

  @override
  void dispose() {
    _mapController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final places = _places;
    final currentPlace = _currentPlace;

    if (places.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ruta activa',
          ),
        ),
        body: const Center(
          child: Text(
            'Esta ruta no contiene paradas.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.route.name,
        ),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: _progress,
            minHeight: 7,
            backgroundColor:
                AppColors.lightMaritimeBlue,
            color: AppColors.lagoonGreen,
          ),

          Expanded(
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(
                target: LatLng(
                  places.first.latitude,
                  places.first.longitude,
                ),
                zoom: 14,
              ),
              onMapCreated:
                  _onMapCreated,
              markers: _markers,
              polylines: _polylines,
              myLocationEnabled:
                  _currentPosition != null,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
            ),
          ),

          if (currentPlace != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(
                AppDimensions.spacingLarge,
              ),
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Parada ${_currentStopIndex + 1} de ${places.length}',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(
                          color:
                              AppColors.lagoonGreen,
                        ),
                  ),
                  const SizedBox(
                    height:
                        AppDimensions.spacingSmall,
                  ),
                  Text(
                    currentPlace.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          fontWeight:
                              FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height:
                        AppDimensions.spacingSmall,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.near_me_outlined,
                        size: 18,
                        color:
                            AppColors.maritimeBlue,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _distanceToCurrentPlace(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height:
                        AppDimensions.spacingMedium,
                  ),
                  if (_routeCompleted)
                    FilledButton.icon(
                      onPressed:
                          _finishRoute,
                      icon: const Icon(
                        Icons.flag,
                      ),
                      label: const Text(
                        'Finalizar ruta',
                      ),
                    )
                  else
                    FilledButton.icon(
                      onPressed:
                          _markCurrentStopVisited,
                      icon: const Icon(
                        Icons.check,
                      ),
                      label: Text(
                        _currentStopIndex ==
                                places.length - 1
                            ? 'Marcar última parada como visitada'
                            : 'Marcar como visitado y continuar',
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton.small(
        heroTag: 'route-location',
        onPressed: _loadLocation,
        tooltip: 'Actualizar ubicación',
        child: _loadingLocation
            ? const SizedBox(
                width: 18,
                height: 18,
                child:
                    CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : const Icon(
                Icons.my_location,
              ),
      ),
    );
  }
}