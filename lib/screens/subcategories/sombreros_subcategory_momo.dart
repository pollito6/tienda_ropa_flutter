import 'package:flutter/material.dart';
import '../../screens/subcategory_template_momo.dart';
import '../../data/products.dart' show products;

class SombrerosSubcategoryMomo extends StatelessWidget {
  const SombrerosSubcategoryMomo({super.key});

  @override
  Widget build(BuildContext context) {
    return SubcategoryTemplateMomo(
      categoryName: 'Accesorios',
      subcategoryName: 'sombreros',
      products: products,
    );
  }
}
