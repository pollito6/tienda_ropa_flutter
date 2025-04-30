import 'package:flutter/material.dart';
import '../../screens/subcategory_template_momo.dart';
import '../../data/products.dart' show products;

class ZapatillasSubcategoryMomo extends StatelessWidget {
  const ZapatillasSubcategoryMomo({super.key});

  @override
  Widget build(BuildContext context) {
    return SubcategoryTemplateMomo(
      categoryName: 'Calzado',
      subcategoryName: 'zapatillas',
      products: products,
    );
  }
}
