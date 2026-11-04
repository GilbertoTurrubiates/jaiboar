import 'package:flutter/material.dart';

import '../../data/mock_tourist_places.dart';
import '../../models/tourist_place.dart';
import '../../services/favorites_service.dart';
import '../../theme/app_dimensions.dart';
import '../../widgets/tourist_place_card.dart';
import '../place_detail/place_detail_view.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() =>
      _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    super.initState();

    FavoritesService.instance.addListener(
      _refresh,
    );
  }

  @override
  void dispose() {
    FavoritesService.instance.removeListener(
      _refresh,
    );

    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  List<TouristPlace> get _favorites {
    return MockTouristPlaces.places.where((place) {
      return FavoritesService.instance
          .isFavorite(place.id);
    }).toList();
  }

  void _openPlace(TouristPlace place) {
    Navigator.of(context)
        .push(
          MaterialPageRoute<void>(
            builder: (_) => PlaceDetailView(
              place: place,
            ),
          ),
        )
        .then((_) {
          if (mounted) {
            setState(() {});
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final favorites = _favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis favoritos'),
      ),
      body: favorites.isEmpty
          ? const _EmptyFavorites()
          : ListView.separated(
              padding: const EdgeInsets.all(
                AppDimensions.screenHorizontalPadding,
              ),
              itemCount: favorites.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(
                height: AppDimensions.spacingMedium,
              ),
              itemBuilder: (context, index) {
                final place = favorites[index];

                return TouristPlaceCard(
                  place: place,
                  compact: true,
                  onPressed: () {
                    _openPlace(place);
                  },
                );
              },
            ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(
          AppDimensions.spacingLarge,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.favorite_border,
              size: 70,
            ),
            const SizedBox(
              height: AppDimensions.spacingMedium,
            ),
            Text(
              'Aún no tienes favoritos',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: AppDimensions.spacingSmall,
            ),
            const Text(
              'Guarda lugares turísticos para '
              'encontrarlos fácilmente después.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}