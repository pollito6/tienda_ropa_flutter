import 'package:flutter/material.dart';
import '../widgets/app_bar_momo.dart';
import '../widgets/menu_momo.dart';
import '../widgets/app_nav.dart';
import '../widgets/product_carousel.dart';
import '../theme/app_colors.dart';
import '../data/products.dart' show products;

class CategoriasMomo extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CategoriasMomo({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Definir las categorías principales que queremos mostrar
    final availableCategories = ['Ropa', 'Accesorios', 'Calzado', 'Bolsos'];
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarMomo(),
      endDrawer: MenuMomo(),
      backgroundColor: AppColors.background,
      bottomNavigationBar: AppNav(
        currentIndex: 1, // Categorías es el índice 1
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/favorites');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/account');
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la página
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Categorías',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            
            // Mostrar cada categoría con su carrusel de productos
            ...availableCategories.map((category) {
              // Filtrar productos por categoría
              final categoryProducts = products
                  .where((product) => product.category.toLowerCase() == category.toLowerCase())
                  .toList();
                  
              // Limitar a 5 productos por carrusel
              final limitedProducts = categoryProducts.length > 5 
                  ? categoryProducts.sublist(0, 5) 
                  : categoryProducts;
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Encabezado de categoría como hipervínculo
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                    child: InkWell(
                      onTap: () {
                        // Navegar a la página de categoría
                        Navigator.pushNamed(
                          context,
                          '/category/${category.toLowerCase()}',
                        );
                      },
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  
                  // Mostrar un solo carrusel con productos de esta categoría
                  ProductCarousel(
                    products: limitedProducts,
                    category: category,
                    subcategory: 'all', // Mostrar todos los productos de la categoría
                    hideTitle: true, // Ocultar el título del carrusel
                  ),
                  
                  // Botón "Ver más" que lleva a la página de la categoría
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/category/${category.toLowerCase()}',
                          );
                        },
                        child: Text(
                          'Ver más...',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
  
  // Obtener categorías únicas de los productos
  List<String> getUniqueCategories() {
    // Usamos products importado desde '../data/products.dart'
    final Set<String> categories = {};
    for (var product in products) {
      categories.add(product.category);
    }
    return categories.toList();
  }
  
  // Obtener subcategorías únicas para una categoría específica
  List<String> getUniqueSubcategories(String category) {
    final Set<String> subcategories = {};
    for (var product in products) {
      if (product.category == category) {
        subcategories.add(product.subcategory);
      }
    }
    return subcategories.toList();
  }
}
