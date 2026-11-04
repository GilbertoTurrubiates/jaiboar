import 'package:flutter/foundation.dart';

class FavoritesService extends ChangeNotifier {
  FavoritesService._();

  static final FavoritesService instance =
      FavoritesService._();

  final Set<String> _favoriteIds = <String>{};

  Set<String> get favoriteIds =>
      Set.unmodifiable(_favoriteIds);

  bool isFavorite(String placeId) {
    return _favoriteIds.contains(placeId);
  }

  void toggleFavorite(String placeId) {
    if (_favoriteIds.contains(placeId)) {
      _favoriteIds.remove(placeId);
    } else {
      _favoriteIds.add(placeId);
    }

    notifyListeners();
  }

  void removeFavorite(String placeId) {
    if (_favoriteIds.remove(placeId)) {
      notifyListeners();
    }
  }

  void clearFavorites() {
    if (_favoriteIds.isEmpty) {
      return;
    }

    _favoriteIds.clear();
    notifyListeners();
  }
}