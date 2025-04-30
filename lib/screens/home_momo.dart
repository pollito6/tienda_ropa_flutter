import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/app_bar_momo.dart';
import '../widgets/menu_momo.dart';
import '../widgets/app_nav.dart';
import '../widgets/product_carousel.dart';
import '../theme/app_colors.dart';
import '../models/category.dart';
import '../models/product.dart'; // Importar la clase Product
import '../data/products.dart';

class HomeMomo extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Random _random = Random();

  // Método para obtener productos aleatorios
  List<Product> _getRandomProducts(int count) {
    // Hacer una copia de la lista para no modificar la original
    final List<Product> shuffledProducts = List.from(products);
    // Mezclar los productos aleatoriamente
    shuffledProducts.shuffle(_random);
    // Devolver los primeros 'count' productos o menos si no hay suficientes
    return shuffledProducts.take(count).toList();
  }

  HomeMomo({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarMomo(),
      endDrawer: MenuMomo(),
      backgroundColor: AppColors.background,
      bottomNavigationBar: AppNav(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0: // Home
              // Ya estamos en Home, no necesitamos navegar
              break;
            case 1: // Favoritos
              Navigator.pushNamed(context, '/favorites');
              break;
            case 2: // Historial
              Navigator.pushNamed(context, '/history');
              break;
            case 3: // Cuenta
              Navigator.pushNamed(context, '/account');
              break;
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lo Más Nuevo
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 8.0),
              child: Text(
                'Lo Más Nuevo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            ProductCarousel(
              products: _getRandomProducts(10), // Productos aleatorios
              subcategory: 'Lo Más Nuevo',
              category: 'Colecciones',
              hideTitle: true,
            ),
            const SizedBox(height: 10), // Espacio adicional
            
            // Hot 🔥
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    'Hot ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    '🔥', // Emoji de fuego
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ProductCarousel(
              products: _getRandomProducts(8), // Productos aleatorios
              subcategory: 'Hot',
              category: 'Colecciones',
              hideTitle: true,
            ),
            const SizedBox(height: 10), // Espacio adicional
            
            // Primavera/Verano
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 8.0),
              child: Text(
                'Primavera/Verano',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            ProductCarousel(
              products: _getRandomProducts(8), // Productos aleatorios
              subcategory: 'Primavera/Verano',
              category: 'Colecciones',
              hideTitle: true,
            ),
            const SizedBox(height: 10), // Espacio adicional
            
            // Categorías - Iconos/botones navegables
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 8.0),
              child: Text(
                'Categorías',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 220, // Aumentado de 120 a 220 para acomodar los iconos más grandes
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        // Navegar a la página de categoría
                        Navigator.pushNamed(
                          context,
                          '/category/${category.name.toLowerCase()}',
                        );
                      },
                      child: Container(
                        width: 160, // Aumentado de 100 a 160
                        margin: EdgeInsets.symmetric(horizontal: 16.0), // Aumentado para dar más espacio
                        child: Column(
                          children: [
                            Container(
                              width: 160, // Duplicado de 80 a 160
                              height: 160, // Duplicado de 80 a 160
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  category.icon,
                                  size: 80, // Duplicado de 40 a 80
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              category.name,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Destacados
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0, bottom: 8.0),
              child: Text(
                'Destacados',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            ProductCarousel(
              products: _getRandomProducts(10), // Productos aleatorios para destacados
              subcategory: 'Destacados',
              category: 'Colecciones',
              hideTitle: true, // Ocultar el título del carrusel
            ),
            
            // Espacio adicional al final
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
