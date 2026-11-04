import 'package:flutter/material.dart';

import '../../data/mock_tourist_places.dart';
import '../../models/place_category.dart';
import '../../models/tourist_place.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../widgets/tourist_place_card.dart';
import '../favorites/favorites_view.dart';
import '../place_detail/place_detail_view.dart';
import '../routes/routes_view.dart';

class ExplorePlaceholderView extends StatefulWidget {
  const ExplorePlaceholderView({super.key});

  @override
  State<ExplorePlaceholderView> createState() =>
      _ExplorePlaceholderViewState();
}

class _ExplorePlaceholderViewState extends State<ExplorePlaceholderView> {
  final TextEditingController _searchController =
      TextEditingController();

  PlaceCategory? _selectedCategory;

  bool _onlyAugmentedReality = false;
  bool _onlyFeatured = false;

  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TouristPlace> get _filteredPlaces {
    final String query =
        _searchQuery.trim().toLowerCase();

    return MockTouristPlaces.places.where((place) {
      final bool matchesCategory =
          _selectedCategory == null ||
              place.category == _selectedCategory;

      final bool matchesAugmentedReality =
          !_onlyAugmentedReality ||
              place.hasAugmentedReality;

      final bool matchesFeatured =
          !_onlyFeatured || place.isFeatured;

      final bool matchesSearch =
          query.isEmpty ||
              place.name.toLowerCase().contains(query) ||
              place.shortDescription
                  .toLowerCase()
                  .contains(query) ||
              place.description
                  .toLowerCase()
                  .contains(query) ||
              place.city
                  .toLowerCase()
                  .contains(query) ||
              place.address
                  .toLowerCase()
                  .contains(query);

      return matchesCategory &&
          matchesAugmentedReality &&
          matchesFeatured &&
          matchesSearch;
    }).toList();
  }

  bool get _hasActiveFilters {
    return _selectedCategory != null ||
        _onlyAugmentedReality ||
        _onlyFeatured ||
        _searchQuery.trim().isNotEmpty;
  }

  void _clearFilters() {
    setState(() {
      _selectedCategory = null;
      _onlyAugmentedReality = false;
      _onlyFeatured = false;
      _searchQuery = '';
      _searchController.clear();
    });
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

  void _openFavorites() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const FavoritesView(),
      ),
    );
  }

  void _openRoutes() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const RoutesView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<TouristPlace> places =
        _filteredPlaces;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.screenHorizontalPadding,
              AppDimensions.screenVerticalPadding,
              AppDimensions.screenHorizontalPadding,
              0,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  _ExploreHeader(
                    onRoutesPressed: _openRoutes,
                    onFavoritesPressed: _openFavorites,
                  ),

                  const SizedBox(
                    height: AppDimensions.spacingSmall,
                  ),

                  Text(
                    'Encuentra sitios históricos, culturales, '
                    'naturales y recreativos de Tampico '
                    'y Ciudad Madero.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                          color: AppColors.secondaryText,
                          height: 1.5,
                        ),
                  ),

                  const SizedBox(
                    height: AppDimensions.spacingLarge,
                  ),

                  TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Buscar lugares...',
                      prefixIcon: const Icon(
                        Icons.search,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              tooltip: 'Limpiar búsqueda',
                              onPressed: () {
                                setState(() {
                                  _searchQuery = '';
                                  _searchController.clear();
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                              ),
                            )
                          : null,
                    ),
                  ),

                  const SizedBox(
                    height: AppDimensions.spacingLarge,
                  ),

                  Text(
                    'Categorías',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w700,
                        ),
                  ),

                  const SizedBox(
                    height: AppDimensions.spacingSmall,
                  ),

                  _CategoryFilters(
                    selectedCategory:
                        _selectedCategory,
                    onSelected: (category) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),

                  const SizedBox(
                    height: AppDimensions.spacingMedium,
                  ),

                  Text(
                    'Filtros adicionales',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.w700,
                        ),
                  ),

                  const SizedBox(
                    height: AppDimensions.spacingSmall,
                  ),

                  Wrap(
                    spacing: AppDimensions.spacingSmall,
                    runSpacing:
                        AppDimensions.spacingSmall,
                    children: [
                      FilterChip(
                        avatar: const Icon(
                          Icons.view_in_ar_outlined,
                          size: 18,
                        ),
                        label: const Text(
                          'Con RA',
                        ),
                        selected:
                            _onlyAugmentedReality,
                        onSelected: (value) {
                          setState(() {
                            _onlyAugmentedReality =
                                value;
                          });
                        },
                      ),
                      FilterChip(
                        avatar: const Icon(
                          Icons.star_outline,
                          size: 18,
                        ),
                        label: const Text(
                          'Destacados',
                        ),
                        selected: _onlyFeatured,
                        onSelected: (value) {
                          setState(() {
                            _onlyFeatured = value;
                          });
                        },
                      ),
                      if (_hasActiveFilters)
                        ActionChip(
                          avatar: const Icon(
                            Icons.restart_alt,
                            size: 18,
                          ),
                          label: const Text(
                            'Restablecer',
                          ),
                          onPressed: _clearFilters,
                        ),
                    ],
                  ),

                  const SizedBox(
                    height: AppDimensions.spacingExtraLarge,
                  ),

                  _ResultsHeader(
                    resultCount: places.length,
                    hasActiveFilters:
                        _hasActiveFilters,
                  ),

                  const SizedBox(
                    height: AppDimensions.spacingMedium,
                  ),
                ],
              ),
            ),
          ),

          if (places.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: _NoResults(
                onClear: _clearFilters,
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal:
                    AppDimensions.screenHorizontalPadding,
              ),
              sliver: SliverList.separated(
                itemCount: places.length,
                separatorBuilder: (_, _) {
                  return const SizedBox(
                    height: AppDimensions.spacingMedium,
                  );
                },
                itemBuilder: (context, index) {
                  final TouristPlace place =
                      places[index];

                  return TouristPlaceCard(
                    place: place,
                    compact: true,
                    onPressed: () {
                      _openPlace(place);
                    },
                  );
                },
              ),
            ),

          const SliverToBoxAdapter(
            child: SizedBox(
              height: AppDimensions.spacingExtraLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreHeader extends StatelessWidget {
  const _ExploreHeader({
    required this.onRoutesPressed,
    required this.onFavoritesPressed,
  });

  final VoidCallback onRoutesPressed;
  final VoidCallback onFavoritesPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(
              'Explora la región',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
        ),

        IconButton(
          tooltip: 'Rutas turísticas',
          onPressed: onRoutesPressed,
          icon: const Icon(
            Icons.route_outlined,
            color: AppColors.maritimeBlue,
          ),
        ),

        IconButton(
          tooltip: 'Mis favoritos',
          onPressed: onFavoritesPressed,
          icon: const Icon(
            Icons.favorite_outline,
            color: AppColors.maritimeBlue,
          ),
        ),
      ],
    );
  }
}

class _CategoryFilters extends StatelessWidget {
  const _CategoryFilters({
    required this.selectedCategory,
    required this.onSelected,
  });

  final PlaceCategory? selectedCategory;
  final ValueChanged<PlaceCategory?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: AppDimensions.spacingSmall,
            ),
            child: FilterChip(
              selected: selectedCategory == null,
              avatar: const Icon(
                Icons.apps,
                size: 18,
              ),
              label: const Text(
                'Todos',
              ),
              onSelected: (_) {
                onSelected(null);
              },
            ),
          ),

          ...PlaceCategory.values.map(
            (category) {
              return Padding(
                padding: const EdgeInsets.only(
                  right: AppDimensions.spacingSmall,
                ),
                child: FilterChip(
                  selected:
                      selectedCategory == category,
                  avatar: Icon(
                    category.icon,
                    size: 18,
                  ),
                  label: Text(
                    category.label,
                  ),
                  onSelected: (_) {
                    onSelected(category);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ResultsHeader extends StatelessWidget {
  const _ResultsHeader({
    required this.resultCount,
    required this.hasActiveFilters,
  });

  final int resultCount;
  final bool hasActiveFilters;

  @override
  Widget build(BuildContext context) {
    final String resultText;

    if (resultCount == 1) {
      resultText = '1 lugar';
    } else {
      resultText = '$resultCount lugares';
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            hasActiveFilters
                ? 'Resultados'
                : 'Todos los lugares',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingSmall,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: AppColors.lightMaritimeBlue,
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusCircular,
            ),
          ),
          child: Text(
            resultText,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(
                  color: AppColors.maritimeBlue,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }
}

class _NoResults extends StatelessWidget {
  const _NoResults({
    required this.onClear,
  });

  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(
          AppDimensions.spacingLarge,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: AppColors.lightMaritimeBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_off,
                size: 46,
                color: AppColors.secondaryText,
              ),
            ),

            const SizedBox(
              height: AppDimensions.spacingLarge,
            ),

            Text(
              'No encontramos resultados',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w700,
                  ),
            ),

            const SizedBox(
              height: AppDimensions.spacingSmall,
            ),

            Text(
              'Intenta cambiar la búsqueda o eliminar '
              'algunos filtros.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                    color: AppColors.secondaryText,
                    height: 1.5,
                  ),
            ),

            const SizedBox(
              height: AppDimensions.spacingLarge,
            ),

            OutlinedButton.icon(
              onPressed: onClear,
              icon: const Icon(
                Icons.restart_alt,
              ),
              label: const Text(
                'Restablecer filtros',
              ),
            ),
          ],
        ),
      ),
    );
  }
}