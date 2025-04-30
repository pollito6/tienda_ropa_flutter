import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/favorites_service.dart';
import '../theme/app_colors.dart';

class FavoriteButton extends StatefulWidget {
  final Product product;

  const FavoriteButton({super.key, required this.product});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final FavoritesService _favoritesService = FavoritesService();

  @override
  Widget build(BuildContext context) {
    final bool isFavorite = _favoritesService.isFavorite(widget.product);

    return GestureDetector(
      onTap: () {
        // Agregar o quitar de favoritos
        _favoritesService.toggleFavorite(widget.product);
        // Actualizar la UI
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : AppColors.primary,
          size: 24,
        ),
      ),
    );
  }
}
