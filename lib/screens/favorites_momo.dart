import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../data/temp_images.dart';
import '../screens/product_detail_momo.dart';
import '../widgets/app_nav.dart';
import '../widgets/app_bar_momo.dart';
import '../widgets/menu_momo.dart';

class FavoritesMomo extends StatefulWidget {
  const FavoritesMomo({super.key});

  @override
  State<FavoritesMomo> createState() => _FavoritesMomoState();
}

class _FavoritesMomoState extends State<FavoritesMomo> {
  final FavoritesService _favoritesService = FavoritesService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Obtener lista de favoritos
    final List<Product> favorites = _favoritesService.favorites;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarMomo(),
      endDrawer: MenuMomo(),
      backgroundColor: AppColors.background,
      bottomNavigationBar: AppNav(
        currentIndex: 1, // Índice 1 corresponde a Favoritos
        onTap: (index) {
          switch (index) {
            case 0: // Home
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1: // Favoritos
              // Ya estamos en Favoritos
              break;
            case 2: // Historial
              // Implementar cuando exista
              break;
            case 3: // Cuenta
              Navigator.pushNamed(context, '/account');
              break;
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la sección con botón de limpiar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mis Favoritos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                if (favorites.isNotEmpty)
                  TextButton.icon(
                    onPressed: () {
                      // Mostrar diálogo de confirmación
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Limpiar favoritos'),
                          content: Text('¿Estás seguro que deseas eliminar todos tus favoritos?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _favoritesService.clearFavorites();
                                });
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              child: Text('Eliminar todo'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    label: Text(
                      'Limpiar',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16),
            
            // Mensaje si no hay favoritos
            if (favorites.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 80,
                        color: AppColors.primary.withValues(alpha: 0.5),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No tienes favoritos',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Agrega productos a favoritos para verlos aquí',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text('Explorar productos'),
                      ),
                    ],
                  ),
                ),
              )
            else
              // Grid de productos favoritos
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.only(bottom: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.6, // Ajustado para mejor proporción
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final product = favorites[index];
                    return _buildProductCard(context, product);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen y botón de favoritos
          Stack(
            children: [
              // Imagen del producto
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailMomo(
                          product: product,
                        ),
                      ),
                    );
                  },
                  child: AspectRatio(
                    aspectRatio: 0.85,
                    child: Image.asset(
                      getProductImagePath(product),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('Error cargando imagen: ${getProductImagePath(product)}');
                        return Image.asset(
                          defaultProductImage,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Botón para eliminar de favoritos
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _favoritesService.toggleFavorite(product);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Información del producto
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nombre del producto
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailMomo(
                              product: product,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  // Precio
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Categoría y subcategoría
                  Text(
                    '${product.category} - ${product.subcategory}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
