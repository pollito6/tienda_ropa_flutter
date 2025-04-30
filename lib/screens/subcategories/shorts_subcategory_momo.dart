import 'package:flutter/material.dart';
import '../../screens/subcategory_template_momo.dart';
import '../../data/products.dart' show products;

class ShortsSubcategoryMomo extends StatelessWidget {
  const ShortsSubcategoryMomo({super.key});

  @override
  Widget build(BuildContext context) {
    return SubcategoryTemplateMomo(
      categoryName: 'Ropa',
      subcategoryName: 'shorts',
      products: products,
    );
  }
}
