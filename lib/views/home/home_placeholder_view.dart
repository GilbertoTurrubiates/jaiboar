import 'package:flutter/material.dart';

import '../../data/mock_tourist_places.dart';
import '../../models/place_category.dart';
import '../../models/tourist_place.dart';
import '../../models/visitor_type.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../widgets/tourist_place_card.dart';
import '../favorites/favorites_view.dart';
import '../place_detail/place_detail_view.dart';

class HomePlaceholderView extends StatefulWidget {
  const HomePlaceholderView({
    this.visitorType,
    this.onExploreRequested,
    super.key,
  });

  final VisitorType? visitorType;
  final VoidCallback? onExploreRequested;

  @override
  State<HomePlaceholderView> createState() =>
      _HomePlaceholderViewState();
}

class _HomePlaceholderViewState extends State<HomePlaceholderView> {
  String get _welcomeMessage {
    switch (widget.visitorType) {
      case VisitorType.tourist:
        return 'Descubre lo mejor de Tampico y Ciudad Madero durante tu visita.';

      case VisitorType.localResident:
        return 'Redescubre Tampico y Ciudad Madero y encuentra nuevos lugares para visitar.';

      case null:
        return 'Descubre Tampico y Ciudad Madero.';
    }
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

  void _openExplore() {
    widget.onExploreRequested?.call();
  }

  void _openCategory(PlaceCategory category) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Categoría seleccionada: ${category.label}',
          ),
        ),
      );

    widget.onExploreRequested?.call();
  }

  @override
  Widget build(BuildContext context) {
    final List<TouristPlace> featuredPlaces =
        MockTouristPlaces.featuredPlaces;

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
                  _HomeHeader(
                    welcomeMessage: _welcomeMessage,
                    onFavoritesPressed: _openFavorites,
                  ),
                  const SizedBox(
                    height: AppDimensions.spacingLarge,
                  ),

                  _SearchPreview(
                    onPressed: _openExplore,
                  ),

                  const SizedBox(
                    height: AppDimensions.spacingExtraLarge,
                  ),

                  _SectionHeader(
                    title: 'Explora por categoría',
                    actionLabel: 'Ver todo',
                    onPressed: _openExplore,
                  ),

                  const SizedBox(
                    height: AppDimensions.spacingMedium,
                  ),

                  _CategoryGrid(
                    onCategoryPressed: _openCategory,
                  ),

                  const SizedBox(
                    height: AppDimensions.spacingExtraLarge,
                  ),

                  _FeaturedBanner(
                    onPressed: _openExplore,
                  ),

                  const SizedBox(
                    height: AppDimensions.spacingExtraLarge,
                  ),

                  _SectionHeader(
                    title: 'Lugares destacados',
                    actionLabel: 'Explorar',
                    onPressed: _openExplore,
                  ),

                  const SizedBox(
                    height: AppDimensions.spacingMedium,
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.screenHorizontalPadding,
            ),
            sliver: SliverList.separated(
              itemCount: featuredPlaces.length,
              separatorBuilder: (_, __) {
                return const SizedBox(
                  height: AppDimensions.spacingMedium,
                );
              },
              itemBuilder: (context, index) {
                final TouristPlace place =
                    featuredPlaces[index];

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

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({
    required this.welcomeMessage,
    required this.onFavoritesPressed,
  });

  final String welcomeMessage;
  final VoidCallback onFavoritesPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Semantics(
                header: true,
                child: Text(
                  'Hola 👋',
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
              tooltip: 'Mis favoritos',
              onPressed: onFavoritesPressed,
              icon: const Icon(
                Icons.favorite_outline,
                color: AppColors.maritimeBlue,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppDimensions.spacingSmall,
        ),
        Text(
          welcomeMessage,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(
                color: AppColors.secondaryText,
                height: 1.5,
              ),
        ),
      ],
    );
  }
}

class _SearchPreview extends StatelessWidget {
  const _SearchPreview({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Buscar lugares turísticos',
      hint: 'Abre la sección Explorar',
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMedium,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusMedium,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingMedium,
              vertical: AppDimensions.spacingMedium,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: AppColors.maritimeBlue,
                ),
                const SizedBox(
                  width: AppDimensions.spacingMedium,
                ),
                Expanded(
                  child: Text(
                    '¿Qué lugar quieres descubrir?',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          color: AppColors.secondaryText,
                        ),
                  ),
                ),
                const Icon(
                  Icons.tune,
                  color: AppColors.secondaryText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.actionLabel,
    required this.onPressed,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(actionLabel),
        ),
      ],
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({
    required this.onCategoryPressed,
  });

  final ValueChanged<PlaceCategory> onCategoryPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int columns =
            constraints.maxWidth >= 600 ? 4 : 2;

        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppDimensions.spacingMedium,
          crossAxisSpacing: AppDimensions.spacingMedium,
          childAspectRatio: 1.35,
          children: PlaceCategory.values.map(
            (category) {
              return _CategoryCard(
                category: category,
                onPressed: () {
                  onCategoryPressed(category);
                },
              );
            },
          ).toList(),
        );
      },
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.onPressed,
  });

  final PlaceCategory category;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Categoría ${category.label}',
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(
              AppDimensions.spacingMedium,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: AppColors.lightLagoonGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    category.icon,
                    color: AppColors.lagoonGreen,
                    size: 27,
                  ),
                ),
                const SizedBox(
                  height: AppDimensions.spacingSmall,
                ),
                Text(
                  category.label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturedBanner extends StatelessWidget {
  const _FeaturedBanner({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        AppDimensions.spacingLarge,
      ),
      decoration: BoxDecoration(
        color: AppColors.maritimeBlue,
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusLarge,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: AppColors.sandOrange,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.travel_explore,
              color: AppColors.darkMaritimeBlue,
              size: 30,
            ),
          ),
          const SizedBox(
            width: AppDimensions.spacingMedium,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Descubre algo nuevo',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Explora sitios destacados de Tampico '
                  'y Ciudad Madero.',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                        color: AppColors.lightMaritimeBlue,
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: AppDimensions.spacingSmall,
          ),
          IconButton(
            tooltip: 'Explorar lugares',
            onPressed: onPressed,
            icon: const Icon(
              Icons.arrow_forward,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}