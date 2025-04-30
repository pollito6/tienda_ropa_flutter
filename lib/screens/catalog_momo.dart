import 'package:flutter/material.dart';
import '../widgets/app_bar_momo.dart';
import '../widgets/menu_momo.dart';
import '../widgets/app_nav.dart';
import '../widgets/product_carousel.dart';
import '../theme/app_colors.dart';
import '../models/product.dart';

class CatalogMomo extends StatefulWidget {
  final String categoryName;
  final List<String> subcategories;

  const CatalogMomo({
    super.key,
    required this.categoryName,
    required this.subcategories,
  });

  @override
  CatalogMomoState createState() => CatalogMomoState();
}

class CatalogMomoState extends State<CatalogMomo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMomo(),
      endDrawer: MenuMomo(),
      backgroundColor: AppColors.background,
      bottomNavigationBar: AppNav(
        currentIndex: -1,
        onTap: (index) {},
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                widget.categoryName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            if (widget.subcategories.isNotEmpty)
              ...widget.subcategories.map((subcategory) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: ProductCarousel(
                    products: demoProducts,
                    subcategory: subcategory,
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
