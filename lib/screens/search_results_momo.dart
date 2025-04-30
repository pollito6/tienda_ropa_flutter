import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../widgets/app_bar_momo.dart';
import '../widgets/menu_momo.dart';
import '../screens/product_detail_momo.dart';
import '../data/temp_images.dart';
import '../services/favorites_service.dart';

class SearchResultsMomo extends StatefulWidget {
  final String query;

  const SearchResultsMomo({super.key, required this.query});

  @override
  State<SearchResultsMomo> createState() => _SearchResultsMomoState();
}

class _SearchResultsMomoState extends State<SearchResultsMomo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Product> _searchResults;
  
  @override
  void initState() {
    super.initState();
    // Realizar la búsqueda
    _searchResults = demoProducts
        .where((p) => 
          p.name.toLowerCase().contains(widget.query.toLowerCase()) ||
          p.category.toLowerCase().contains(widget.query.toLowerCase()) ||
          p.subcategory.toLowerCase().contains(widget.query.toLowerCase())
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarMomo(),
      endDrawer: MenuMomo(),
      backgroundColor: AppColors.background,
      // Navegación inferior con el mismo diseño que en CartMomo
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 51),
              blurRadius: 5,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: BottomAppBar(
          color: AppColors.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home_outlined, color: Colors.white, size: 28),
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.white, size: 28),
                onPressed: () => Navigator.pushReplacementNamed(context, '/favorites'),
              ),
              IconButton(
                icon: Icon(Icons.history, color: Colors.white, size: 28),
                onPressed: () => Navigator.pushReplacementNamed(context, '/history'),
              ),
              IconButton(
                icon: Icon(Icons.person_outline, color: Colors.white, size: 28),
                onPressed: () => Navigator.pushReplacementNamed(context, '/account'),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado de resultados
            Text(
              'Resultados para "${widget.query}"',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${_searchResults.length} producto${_searchResults.length != 1 ? "s" : ""} encontrado${_searchResults.length != 1 ? "s" : ""}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            
            // Mostrar resultados o mensaje de no encontrado
            _searchResults.isEmpty
              ? Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 60,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No se encontraron productos',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Intenta con otra palabra clave',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final product = _searchResults[index];
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
    final FavoritesService _favoritesService = FavoritesService();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 26),
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
              // Botón de favoritos
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
                          color: Colors.black.withValues(alpha: 26),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Icon(
                      _favoritesService.isFavorite(product) 
                        ? Icons.favorite 
                        : Icons.favorite_border,
                      color: _favoritesService.isFavorite(product) 
                        ? Colors.red 
                        : Colors.grey,
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
