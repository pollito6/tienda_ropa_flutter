import 'package:flutter/material.dart';
import '../../screens/subcategory_template_momo.dart';
import '../../data/products.dart' show products;

class LenceriaSubcategoryMomo extends StatelessWidget {
  const LenceriaSubcategoryMomo({super.key});

  @override
  Widget build(BuildContext context) {
    return SubcategoryTemplateMomo(
      categoryName: 'Ropa',
      subcategoryName: 'Lencería',
      products: products,
    );
  }
}
