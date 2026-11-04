import 'package:flutter/material.dart';

enum PlaceCategory {
  historical,
  cultural,
  natural,
  recreational,
}

extension PlaceCategoryExtension on PlaceCategory {
  String get label {
    switch (this) {
      case PlaceCategory.historical:
        return 'Históricos';
      case PlaceCategory.cultural:
        return 'Culturales';
      case PlaceCategory.natural:
        return 'Naturaleza';
      case PlaceCategory.recreational:
        return 'Recreativos';
    }
  }

  IconData get icon {
    switch (this) {
      case PlaceCategory.historical:
        return Icons.account_balance_outlined;
      case PlaceCategory.cultural:
        return Icons.museum_outlined;
      case PlaceCategory.natural:
        return Icons.park_outlined;
      case PlaceCategory.recreational:
        return Icons.attractions_outlined;
    }
  }
}