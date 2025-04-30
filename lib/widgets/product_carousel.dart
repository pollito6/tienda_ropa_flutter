import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../data/temp_images.dart';
import '../screens/product_detail_momo.dart';
import '../widgets/favorite_button.dart';

class ProductCarousel extends StatelessWidget {
  final List<Product> products;
  final String subcategory;
  final String? category; // Categoría opcional, si no se proporciona se tomará del primer producto
  final bool hideTitle; // Para ocultar el título cuando se muestra en la página Home

  const ProductCarousel({
    super.key,
    required this.products,
    required this.subcategory,
    this.category,
    this.hideTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    // Lista de nombres de colecciones especiales que no deben filtrar por subcategoría
    final specialCollections = [
      'lo más nuevo', 'lo mas nuevo', 'hot', 'primavera/verano', 
      'destacados', 'colecciones', 'recomendados', 'populares'
    ];
    
    // Determinar si esta es una colección especial
    final isSpecialCollection = specialCollections.contains(subcategory.toLowerCase());
    
    // Filtrar productos dependiendo del tipo de subcategoría
    List<Product> filteredProducts;
    
    if (isSpecialCollection) {
      // Para colecciones especiales, usar los productos proporcionados sin filtrar
      filteredProducts = products;
      print('Mostrando colección especial: $subcategory con ${filteredProducts.length} productos');
    } else if (subcategory.toLowerCase() == 'all') {
      // Si es 'all', mostrar todos los productos de la categoría especificada
      if (category != null) {
        filteredProducts = products.where((product) => 
          product.category.toLowerCase() == category!.toLowerCase()
        ).toList();
      } else {
        // Si no se especifica categoría, mostrar todos los productos
        filteredProducts = products;
      }
    } else {
      // Filtrar por subcategoría específica
      filteredProducts = products.where((product) => 
        product.subcategory.toLowerCase() == subcategory.toLowerCase()
      ).toList();
    }

    if (filteredProducts.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título del carrusel (opcional)
        if (!hideTitle)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                // Determinar la categoría a usar
                final String categoryName = category ?? 
                    (filteredProducts.isNotEmpty ? filteredProducts.first.category : 'Ropa');
                
                if (subcategory.toLowerCase() == 'all') {
                  // Si es 'all', navegar a la página de categoría
                  Navigator.pushNamed(
                    context,
                    '/category/${categoryName.toLowerCase()}',
                  );
                } else {
                  // Navegar a la página específica de subcategoría
                  Navigator.pushNamed(
                    context,
                    '/subcategory/${categoryName.toLowerCase()}/${subcategory.toLowerCase()}',
                  );
                }
              },
              child: Text(
                subcategory.toLowerCase() == 'all' ? (category ?? 'Productos') : subcategory,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        // Indicadores de desplazamiento horizontal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Flecha izquierda para indicar desplazamiento
            if (filteredProducts.length > 1)
              Icon(
                Icons.arrow_back_ios,
                color: AppColors.secondary.withValues(alpha: 0.5),
                size: 20,
              ),
            Expanded(
              child: SizedBox(),
            ),
            // Flecha derecha para indicar desplazamiento
            if (filteredProducts.length > 1)
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.secondary.withValues(alpha: 0.5),
                size: 20,
              ),
          ],
        ),
        
        // Espacio para separar los elementos
        SizedBox(height: 8.0),
        
        Container(
          height: 500, // Altura total para la imagen (400) + texto (100)
          decoration: BoxDecoration(
            gradient: filteredProducts.length > 1 ? LinearGradient(
              colors: [
                AppColors.background.withValues(alpha: 0.2),
                AppColors.background,
                AppColors.background,
                AppColors.background.withValues(alpha: 0.2),
              ],
              stops: [0.0, 0.1, 0.9, 1.0],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ) : null,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(), // Agregar efecto de rebote para indicar los límites
            itemCount: filteredProducts.length > 10 ? 10 : filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return Container(
                width: 400,
                margin: EdgeInsets.symmetric(horizontal: 8.0),
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
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                          child: Image.asset(
                            getProductImagePath(product),
                            width: 400,
                            height: 400,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              print('Error cargando imagen: ${getProductImagePath(product)}');
                              return Image.asset(
                                defaultProductImage,
                                width: 400,
                                height: 400,
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                        ),
                        // Botón de favoritos
                        Positioned(
                          top: 8,
                          right: 8,
                          child: FavoriteButton(product: product),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
