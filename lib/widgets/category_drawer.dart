import 'package:flutter/material.dart';
import '../models/category.dart';
import '../theme/app_colors.dart';
import '../screens/catalog_momo.dart';

class CategoryDrawer extends StatelessWidget {
  const CategoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.tertiary,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/categorias');
                  },
                  child: Text(
                    'Categorías',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _buildCategoryTile(context, category);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTile(BuildContext context, Category category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Categoría principal
        ListTile(
          title: Text(
            category.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CatalogMomo(
                  categoryName: category.name,
                  subcategories: category.subcategories,
                ),
              ),
            );
          },
        ),
        // Subcategorías
        if (category.subcategories.isNotEmpty)
          ...category.subcategories.map((subcategory) {
            return ListTile(
              contentPadding: EdgeInsets.only(left: 32),
              title: Text(
                subcategory,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/subcategory',
                  arguments: {
                    'category': category.name,
                    'subcategory': subcategory,
                  },
                );                
              },
            );
          }),
        Divider(),
      ],
    );
  }
}
