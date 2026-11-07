import 'package:flutter/material.dart';

import '../../models/place_category.dart';
import '../../routes/app_routes.dart';
import '../../models/tourist_place.dart';
import '../../services/favorites_service.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';

class PlaceDetailView extends StatefulWidget {
  const PlaceDetailView({
    required this.place,
    super.key,
  });

  final TouristPlace place;

  @override
  State<PlaceDetailView> createState() =>
      _PlaceDetailViewState();
}

class _PlaceDetailViewState extends State<PlaceDetailView> {
  @override
  Widget build(BuildContext context) {
    final TouristPlace place = widget.place;
    final bool isFavorite =
        FavoritesService.instance.isFavorite(place.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del lugar'),
        actions: [
          IconButton(
            tooltip: isFavorite
                ? 'Eliminar de favoritos'
                : 'Agregar a favoritos',
            onPressed: () {
              setState(() {
                FavoritesService.instance.toggleFavorite(
                  place.id,
                );
              });
            },
            icon: Icon(
              isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: isFavorite
                  ? AppColors.sandOrange
                  : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          AppDimensions.screenHorizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.lightMaritimeBlue,
                borderRadius: BorderRadius.circular(
                  AppDimensions.radiusLarge,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      place.category.icon,
                      size: 90,
                      color: AppColors.maritimeBlue,
                    ),
                  ),
                  if (place.hasAugmentedReality)
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Chip(
                        avatar: const Icon(
                          Icons.view_in_ar_outlined,
                          size: 18,
                        ),
                        label: const Text('Experiencia RA'),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: AppDimensions.spacingLarge,
            ),
            Text(
              place.category.label,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(
                    color: AppColors.lagoonGreen,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: AppDimensions.spacingSmall,
            ),
            Text(
              place.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(
              height: AppDimensions.spacingMedium,
            ),
            Wrap(
              spacing: 18,
              runSpacing: 10,
              children: [
                _DetailIndicator(
                  icon: Icons.star,
                  text: place.rating.toStringAsFixed(1),
                ),
                _DetailIndicator(
                  icon: Icons.schedule_outlined,
                  text: '${place.estimatedMinutes} min',
                ),
                _DetailIndicator(
                  icon: Icons.location_city_outlined,
                  text: place.city,
                ),
              ],
            ),
            const SizedBox(
              height: AppDimensions.spacingExtraLarge,
            ),
            const _SectionTitle(
              title: 'Acerca del lugar',
            ),
            const SizedBox(
              height: AppDimensions.spacingSmall,
            ),
            Text(
              place.description,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                    height: 1.6,
                  ),
            ),
            const SizedBox(
              height: AppDimensions.spacingExtraLarge,
            ),
            const _SectionTitle(
              title: 'Información para tu visita',
            ),
            const SizedBox(
              height: AppDimensions.spacingMedium,
            ),
            _InformationCard(
              icon: Icons.location_on_outlined,
              title: 'Ubicación',
              value: place.address,
            ),
            _InformationCard(
              icon: Icons.access_time,
              title: 'Horario',
              value: place.schedule,
            ),
            _InformationCard(
              icon: Icons.payments_outlined,
              title: 'Acceso',
              value: place.price,
            ),
            _InformationCard(
              icon: Icons.timer_outlined,
              title: 'Tiempo estimado',
              value: '${place.estimatedMinutes} minutos',
            ),
            if (place.hasAugmentedReality) ...[
              const SizedBox(
                height: AppDimensions.spacingLarge,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(
                    AppDimensions.spacingLarge,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.view_in_ar_outlined,
                        size: 40,
                        color: AppColors.sandOrange,
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
                              'Experiencia RA disponible',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight:
                                        FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Puedes probar una simulación de RA. La cámara y el reconocimiento real se implementarán después.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.spacingSmall),
              FilledButton.icon(
                onPressed: () => Navigator.of(context).pushNamed(
                  AppRoutes.arExperience,
                  arguments: place.id,
                ),
                icon: const Icon(Icons.view_in_ar_outlined),
                label: const Text('Iniciar simulación RA'),
              ),
            ],
            const SizedBox(
              height: AppDimensions.spacingExtraLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _DetailIndicator extends StatelessWidget {
  const _DetailIndicator({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.sandOrange,
        ),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}

class _InformationCard extends StatelessWidget {
  const _InformationCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: AppDimensions.spacingSmall,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.maritimeBlue,
        ),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}