import 'package:flutter/material.dart';
import '../../screens/subcategory_template_momo.dart';
import '../../data/products.dart' show products;

class CalcetinesSubcategoryMomo extends StatelessWidget {
  const CalcetinesSubcategoryMomo({super.key});

  @override
  Widget build(BuildContext context) {
    return SubcategoryTemplateMomo(
      categoryName: 'Ropa',
      subcategoryName: 'calcetines',
      products: products,
    );
  }
}
