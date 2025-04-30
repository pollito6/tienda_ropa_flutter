import 'package:flutter/material.dart';
import '../../screens/subcategory_template_momo.dart';
import '../../data/products.dart' show products;

class FaldasSubcategoryMomo extends StatelessWidget {
  const FaldasSubcategoryMomo({super.key});

  @override
  Widget build(BuildContext context) {
    return SubcategoryTemplateMomo(
      categoryName: 'Ropa',
      subcategoryName: 'faldas',
      products: products,
    );
  }
}
