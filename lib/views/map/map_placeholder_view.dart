import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/mock_tourist_places.dart';
import '../../models/tourist_place.dart';
import '../../services/location_service.dart';
import '../../services/map_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../place_detail/place_detail_view.dart';

class MapPlaceholderView extends StatefulWidget {
  const MapPlaceholderView({super.key});

  @override
  State<MapPlaceholderView> createState() =>
      _MapPlaceholderViewState();
}

class _MapPlaceholderViewState
    extends State<MapPlaceholderView> {
  final LocationService _locationService =
      const LocationService();

  final MapService _mapService =
      const MapService();

  GoogleMapController? _mapController;

  TouristPlace? _selectedPlace;
  Position? _currentPosition;

  bool _isLoadingLocation = false;
  bool _myLocationEnabled = false;

  String? _locationMessage;

  Set<Marker> get _markers {
    return _mapService.buildTouristPlaceMarkers(
      places: MockTouristPlaces.places,
      onSelected: _selectPlace,
    );
  }

  @override
  void initState() {
    super.initState();

    _requestLocation();
  }

  void _onMapCreated(
    GoogleMapController controller,
  ) {
    _mapController = controller;
  }

  void _selectPlace(TouristPlace place) {
    setState(() {
      _selectedPlace = place;
    });
  }

  Future<void> _requestLocation() async {
    if (_isLoadingLocation) {
      return;
    }

    setState(() {
      _isLoadingLocation = true;
      _locationMessage = null;
    });

    final LocationRequestResult result =
        await _locationService
            .getCurrentLocation();

    if (!mounted) {
      return;
    }

    switch (result.status) {
      case LocationRequestStatus.success:
        setState(() {
          _currentPosition = result.position;
          _myLocationEnabled = true;
          _locationMessage = null;
        });

        if (result.position != null) {
          await _moveToPosition(
            result.position!,
          );
        }

        break;

      case LocationRequestStatus.serviceDisabled:
        setState(() {
          _myLocationEnabled = false;
          _locationMessage =
              'La ubicación del dispositivo está desactivada.';
        });

        break;

      case LocationRequestStatus.permissionDenied:
        setState(() {
          _myLocationEnabled = false;
          _locationMessage =
              'No se concedió permiso para acceder a tu ubicación.';
        });

        break;

      case LocationRequestStatus.permissionDeniedForever:
        setState(() {
          _myLocationEnabled = false;
          _locationMessage =
              'El permiso de ubicación está bloqueado. Actívalo desde los ajustes de la aplicación.';
        });

        break;

      case LocationRequestStatus.unavailable:
        setState(() {
          _myLocationEnabled = false;
          _locationMessage =
              'No fue posible determinar tu ubicación.';
        });

        break;
    }

    if (mounted) {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  Future<void> _moveToPosition(
    Position position,
  ) async {
    final GoogleMapController? controller =
        _mapController;

    if (controller == null) {
      return;
    }

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            position.latitude,
            position.longitude,
          ),
          zoom: 15,
        ),
      ),
    );
  }

  Future<void> _centerOnCurrentLocation() async {
    if (_currentPosition == null) {
      await _requestLocation();
      return;
    }

    await _moveToPosition(
      _currentPosition!,
    );
  }

  void _openPlace(TouristPlace place) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PlaceDetailView(
          place: place,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition:
                  MapService.initialCameraPosition,
              onMapCreated: _onMapCreated,
              markers: _markers,
              myLocationEnabled:
                  _myLocationEnabled,
              myLocationButtonEnabled: false,
              compassEnabled: true,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              onTap: (_) {
                setState(() {
                  _selectedPlace = null;
                });
              },
            ),
          ),

          Positioned(
            top: AppDimensions.spacingMedium,
            left: AppDimensions
                .screenHorizontalPadding,
            right: AppDimensions
                .screenHorizontalPadding,
            child: _MapHeader(
              isLoadingLocation:
                  _isLoadingLocation,
            ),
          ),

          if (_locationMessage != null)
            Positioned(
              top: 95,
              left: AppDimensions
                  .screenHorizontalPadding,
              right: AppDimensions
                  .screenHorizontalPadding,
              child: _LocationWarning(
                message: _locationMessage!,
                onRetry: _requestLocation,
                onOpenLocationSettings:
                    _locationService
                        .openLocationSettings,
                onOpenAppSettings:
                    _locationService
                        .openAppSettings,
              ),
            ),

          Positioned(
            right: AppDimensions
                .screenHorizontalPadding,
            bottom:
                _selectedPlace == null ? 24 : 150,
            child: FloatingActionButton(
              heroTag: 'map-current-location',
              tooltip: 'Mi ubicación',
              onPressed:
                  _centerOnCurrentLocation,
              backgroundColor: AppColors.white,
              foregroundColor:
                  AppColors.maritimeBlue,
              child: _isLoadingLocation
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2.5,
                      ),
                    )
                  : const Icon(
                      Icons.my_location,
                    ),
            ),
          ),

          if (_selectedPlace != null)
            Positioned(
              left: AppDimensions
                  .screenHorizontalPadding,
              right: AppDimensions
                  .screenHorizontalPadding,
              bottom:
                  AppDimensions.spacingMedium,
              child: _SelectedPlaceCard(
                place: _selectedPlace!,
                onPressed: () {
                  _openPlace(
                    _selectedPlace!,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _MapHeader extends StatelessWidget {
  const _MapHeader({
    required this.isLoadingLocation,
  });

  final bool isLoadingLocation;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          AppDimensions.spacingMedium,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.map_outlined,
              color: AppColors.maritimeBlue,
            ),
            const SizedBox(
              width: AppDimensions.spacingMedium,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mapa turístico',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                          fontWeight:
                              FontWeight.w700,
                        ),
                  ),
                  Text(
                    isLoadingLocation
                        ? 'Obteniendo ubicación...'
                        : 'Tampico y Ciudad Madero',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                          color: AppColors
                              .secondaryText,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedPlaceCard extends StatelessWidget {
  const _SelectedPlaceCard({
    required this.place,
    required this.onPressed,
  });

  final TouristPlace place;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          AppDimensions.spacingMedium,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.sandOrange,
              size: 34,
            ),
            const SizedBox(
              width: AppDimensions.spacingMedium,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                          fontWeight:
                              FontWeight.w700,
                        ),
                  ),
                  Text(
                    place.city,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Ver lugar',
              onPressed: onPressed,
              icon: const Icon(
                Icons.arrow_forward,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationWarning extends StatelessWidget {
  const _LocationWarning({
    required this.message,
    required this.onRetry,
    required this.onOpenLocationSettings,
    required this.onOpenAppSettings,
  });

  final String message;
  final VoidCallback onRetry;
  final VoidCallback onOpenLocationSettings;
  final VoidCallback onOpenAppSettings;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          AppDimensions.spacingMedium,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_off_outlined,
                  color: AppColors.sandOrange,
                ),
                const SizedBox(
                  width:
                      AppDimensions.spacingSmall,
                ),
                Expanded(
                  child: Text(message),
                ),
              ],
            ),
            const SizedBox(
              height: AppDimensions.spacingSmall,
            ),
            Wrap(
              spacing:
                  AppDimensions.spacingSmall,
              children: [
                TextButton(
                  onPressed: onRetry,
                  child:
                      const Text('Reintentar'),
                ),
                TextButton(
                  onPressed:
                      onOpenLocationSettings,
                  child: const Text(
                    'Ubicación',
                  ),
                ),
                TextButton(
                  onPressed:
                      onOpenAppSettings,
                  child:
                      const Text('Permisos'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}