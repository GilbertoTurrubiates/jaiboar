import 'package:flutter/material.dart';

import '../models/place_category.dart';
import '../models/tourist_place.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class TouristPlaceCard extends StatelessWidget {
  const TouristPlaceCard({
    required this.place,
    required this.onPressed,
    this.compact = false,
    super.key,
  });

  final TouristPlace place;
  final VoidCallback onPressed;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label:
          '${place.name}. ${place.shortDescription}. '
          'Calificación ${place.rating}.',
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: compact
              ? _CompactContent(place: place)
              : _RegularContent(place: place),
        ),
      ),
    );
  }
}

class _RegularContent extends StatelessWidget {
  const _RegularContent({
    required this.place,
  });

  final TouristPlace place;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _PlaceIllustration(
          place: place,
          height: 150,
        ),
        Padding(
          padding: const EdgeInsets.all(
            AppDimensions.spacingMedium,
          ),
          child: _PlaceInformation(
            place: place,
          ),
        ),
      ],
    );
  }
}

class _CompactContent extends StatelessWidget {
  const _CompactContent({
    required this.place,
  });

  final TouristPlace place;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: _PlaceIllustration(
            place: place,
            height: 150,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(
              AppDimensions.spacingMedium,
            ),
            child: _PlaceInformation(
              place: place,
            ),
          ),
        ),
      ],
    );
  }
}

class _PlaceInformation extends StatelessWidget {
  const _PlaceInformation({
    required this.place,
  });

  final TouristPlace place;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          place.category.label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.lagoonGreen,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(
          height: AppDimensions.spacingExtraSmall,
        ),
        Text(
          place.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primaryText,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(
          height: AppDimensions.spacingSmall,
        ),
        Text(
          place.shortDescription,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.secondaryText,
              ),
        ),
        const SizedBox(
          height: AppDimensions.spacingMedium,
        ),
        Wrap(
          spacing: AppDimensions.spacingMedium,
          runSpacing: AppDimensions.spacingSmall,
          children: [
            _InformationItem(
              icon: Icons.star,
              text: place.rating.toStringAsFixed(1),
            ),
            _InformationItem(
              icon: Icons.schedule_outlined,
              text: '${place.estimatedMinutes} min',
            ),
            _InformationItem(
              icon: Icons.location_on_outlined,
              text: place.city,
            ),
          ],
        ),
      ],
    );
  }
}

class _InformationItem extends StatelessWidget {
  const _InformationItem({
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
          size: 17,
          color: AppColors.sandOrange,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.secondaryText,
              ),
        ),
      ],
    );
  }
}

class _PlaceIllustration extends StatelessWidget {
  const _PlaceIllustration({
    required this.place,
    required this.height,
  });

  final TouristPlace place;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: AppColors.lightMaritimeBlue,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Icon(
              place.category.icon,
              size: 58,
              color: AppColors.maritimeBlue,
            ),
          ),
          if (place.hasAugmentedReality)
            Positioned(
              top: AppDimensions.spacingSmall,
              right: AppDimensions.spacingSmall,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacingSmall,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.sandOrange,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusCircular,
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.view_in_ar_outlined,
                      size: 16,
                      color: AppColors.darkMaritimeBlue,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'RA',
                      style: TextStyle(
                        color: AppColors.darkMaritimeBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}