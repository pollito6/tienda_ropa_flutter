import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../widgets/app_bar_momo.dart';
import '../widgets/menu_momo.dart';
import '../widgets/app_nav.dart';
import '../screens/product_detail_momo.dart';
import '../data/temp_images.dart';

class SubcategoryMomo extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String categoryName;
  final String subcategoryName;
  final List<Product> products;

  SubcategoryMomo({
    super.key,
    required this.categoryName,
    required this.subcategoryName,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    print('DEBUG - CategoryName: $categoryName, SubcategoryName: $subcategoryName');
    
    // Si subcategoryName es 'all', mostramos todos los productos de esa categoría
    final filteredProducts = products.where((product) {
      if (subcategoryName.toLowerCase() == 'all') {
        print('DEBUG - Showing all products in category: ${product.category} == $categoryName? ${product.category.toLowerCase() == categoryName.toLowerCase()}');
        return product.category.toLowerCase() == categoryName.toLowerCase();
      } else {
        print('DEBUG - Filtering for subcategory: ${product.subcategory} == $subcategoryName? ${product.subcategory.toLowerCase() == subcategoryName.toLowerCase()}');
        return product.category.toLowerCase() == categoryName.toLowerCase() &&
               product.subcategory.toLowerCase() == subcategoryName.toLowerCase();
      }
    }).toList();
    
    print('DEBUG - Found ${filteredProducts.length} products');
    
    if (filteredProducts.isEmpty) {
      print('DEBUG - No products found for category: $categoryName, subcategory: $subcategoryName');
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarMomo(),
      endDrawer: MenuMomo(),
      backgroundColor: AppColors.background,
      bottomNavigationBar: AppNav(
        currentIndex: -1,
        onTap: (index) {},
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  subcategoryName.toLowerCase() == 'all' ? 'Todos los productos' : subcategoryName,
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
            child: GridView.builder(
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
                              defaultProductImage,
                              fit: BoxFit.cover,
                              width: double.infinity,
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
