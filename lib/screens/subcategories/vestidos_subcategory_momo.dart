import 'package:flutter/material.dart';
import '../../screens/subcategory_template_momo.dart';
import '../../data/products.dart' show products;

class VestidosSubcategoryMomo extends StatelessWidget {
  const VestidosSubcategoryMomo({super.key});

  @override
  Widget build(BuildContext context) {
    return SubcategoryTemplateMomo(
      categoryName: 'Ropa',
      subcategoryName: 'vestidos',
      products: products,
    );
  }
}
