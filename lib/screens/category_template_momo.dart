import 'package:flutter/material.dart';
import '../widgets/app_bar_momo.dart';
import '../widgets/menu_momo.dart';
import '../widgets/app_nav.dart';
import '../widgets/product_carousel.dart';
import '../theme/app_colors.dart';
import '../data/products.dart' show products;

class CategoryTemplateMomo extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String categoryName;
  final List<String> subcategories;

  CategoryTemplateMomo({
    super.key,
    required this.categoryName,
    required this.subcategories,
  });
  
  @override
  Widget build(BuildContext context) {
    // Filtrar productos por categoría
    final categoryProducts = products
        .where((product) => product.category.toLowerCase() == categoryName.toLowerCase())
        .toList();
        
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarMomo(),
      endDrawer: MenuMomo(),
      backgroundColor: AppColors.background,
      bottomNavigationBar: AppNav(
        currentIndex: 0, // Índice 0 para Home (por defecto)
        onTap: (index) {
          // Manejar la navegación según el índice seleccionado
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/categorias');
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
            // Título de la categoría
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                categoryName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            
            // Mostrar subcategorías con carrusel de productos
            ...subcategories.map((subcategory) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Encabezado de subcategoría como hipervínculo
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: GestureDetector(
                      onTap: () {
                        // Navegar a la página específica de subcategoría
                        Navigator.pushNamed(
                          context,
                          '/subcategory/${categoryName.toLowerCase()}/${subcategory.toLowerCase()}',
                        );
                      },
                      child: Text(
                        subcategory,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  
                  // Carrusel de productos para esta subcategoría
                  ProductCarousel(
                    products: categoryProducts,
                    subcategory: subcategory.toLowerCase(),
                    category: categoryName,
                    hideTitle: true, // Ocultar el título del carrusel
                  ),
                  
                  // Botón "Ver más" que lleva a la página de la subcategoría
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/subcategory/${categoryName.toLowerCase()}/${subcategory.toLowerCase()}',
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
}
