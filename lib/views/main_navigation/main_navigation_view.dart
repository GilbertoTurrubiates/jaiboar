import 'package:flutter/material.dart';

import '../../models/visitor_type.dart';
import '../../theme/app_colors.dart';
import '../../widgets/main_navigation_bar.dart';
import '../augmented_reality/ar_placeholder_view.dart';
import '../explore/explore_placeholder_view.dart';
import '../home/home_placeholder_view.dart';
import '../map/map_placeholder_view.dart';
import '../profile/profile_placeholder_view.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({
    this.visitorType,
    super.key,
  });

  final VisitorType? visitorType;

  @override
  State<MainNavigationView> createState() =>
      _MainNavigationViewState();
}

class _MainNavigationViewState
    extends State<MainNavigationView> {
  static const int _homeIndex = 0;
  static const int _exploreIndex = 1;
  static const int _mapIndex = 2;
  static const int _arIndex = 3;
  static const int _profileIndex = 4;

  int _currentIndex = _homeIndex;

  late final List<Widget> _pages;

  static const List<String> _titles = [
    'Inicio',
    'Explorar',
    'Mapa turístico',
    'Cámara RA',
    'Perfil',
  ];

  @override
  void initState() {
    super.initState();

    _pages = [
      HomePlaceholderView(
        visitorType: widget.visitorType,
        onExploreRequested: _openExplore,
      ),
      const ExplorePlaceholderView(),
      const MapPlaceholderView(),
      const ArPlaceholderView(),
      ProfilePlaceholderView(
        visitorType: widget.visitorType,
      ),
    ];
  }

  void _openExplore() {
    _selectSection(_exploreIndex);
  }

  void _selectSection(int index) {
    if (index < _homeIndex || index > _profileIndex) {
      return;
    }

    if (_currentIndex == index) {
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  void _handleBack() {
    if (_currentIndex != _homeIndex) {
      setState(() {
        _currentIndex = _homeIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isHomeSelected =
        _currentIndex == _homeIndex;

    return PopScope(
      canPop: isHomeSelected,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }

        _handleBack();
      },
      child: Scaffold(
        backgroundColor: AppColors.neutralGray,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            _titles[_currentIndex],
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: MainNavigationBar(
          currentIndex: _currentIndex,
          onDestinationSelected: _selectSection,
        ),
      ),
    );
  }
}