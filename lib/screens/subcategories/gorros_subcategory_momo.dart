import 'package:flutter/material.dart';
import '../../screens/subcategory_template_momo.dart';
import '../../data/products.dart' show products;

class GorrosSubcategoryMomo extends StatelessWidget {
  const GorrosSubcategoryMomo({super.key});

  @override
  Widget build(BuildContext context) {
    return SubcategoryTemplateMomo(
      categoryName: 'Accesorios',
      subcategoryName: 'gorros',
      products: products,
    );
  }
}
