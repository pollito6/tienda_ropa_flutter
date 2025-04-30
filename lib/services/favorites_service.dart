import 'package:flutter/foundation.dart';
import '../models/product.dart';

/// Servicio que gestiona los productos favoritos
class FavoritesService extends ChangeNotifier {
  // Singleton
  static final FavoritesService _instance = FavoritesService._internal();
  factory FavoritesService() => _instance;
  FavoritesService._internal();

  // Lista de productos favoritos
  final List<Product> _favorites = [];

  // Obtener todos los favoritos
  List<Product> get favorites => _favorites;

  // Verificar si un producto es favorito
  bool isFavorite(Product product) {
    return _favorites.any((p) => p.name == product.name);
  }

  // Agregar o quitar un producto de favoritos
  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      _favorites.removeWhere((p) => p.name == product.name);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  // Quitar un producto de favoritos
  void removeFavorite(Product product) {
    _favorites.removeWhere((p) => p.name == product.name);
    notifyListeners();
  }

  // Limpiar todos los favoritos
  void clearFavorites() {
    _favorites.clear();
    notifyListeners();
  }
}
