import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../widgets/app_bar_momo.dart';
import '../widgets/menu_momo.dart';
import '../widgets/app_nav.dart';
import '../screens/product_detail_momo.dart';
import '../data/temp_images.dart';

class SubcategoryTemplateMomo extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String categoryName;
  final String subcategoryName;
  final List<Product> products;

  SubcategoryTemplateMomo({
    super.key,
    required this.categoryName,
    required this.subcategoryName,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    // Filtrar productos por categoría y subcategoría (ignorando mayúsculas y minúsculas)
    final filteredProducts = products.where((product) =>
        product.category.toLowerCase() == categoryName.toLowerCase() &&
        product.subcategory.toLowerCase() == subcategoryName.toLowerCase()
    ).toList();
    
    // Asegurarnos de tener nombres de categoría y subcategoría con formato consistente para presentación
    final displayCategoryName = categoryName[0].toUpperCase() + categoryName.substring(1);
    final displaySubcategoryName = subcategoryName[0].toUpperCase() + subcategoryName.substring(1);
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarMomo(),
      endDrawer: MenuMomo(),
      backgroundColor: AppColors.background,
      bottomNavigationBar: AppNav(
        currentIndex: 0, // Índice 0 para Home (por defecto)
        onTap: (index) {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Encabezado de categoría con enlace a la página de categoría
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/category/${categoryName.toLowerCase()}',
                    );
                  },
                  child: Text(
                    displayCategoryName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // Nombre de la subcategoría
                Text(
                  displaySubcategoryName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                    child: Text(
                      'No hay productos disponibles',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.secondary,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return GestureDetector(
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
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
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(8),
                                  ),
                                  child: Image.asset(
                                    getProductImagePath(product),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      print('Error loading image: ${getProductImagePath(product)}');
                                      return Image.asset(
                                        defaultProductImage,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
