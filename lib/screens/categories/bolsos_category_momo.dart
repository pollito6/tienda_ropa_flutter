import 'package:flutter/material.dart';
import '../../screens/category_template_momo.dart';

class BolsosCategoryMomo extends StatelessWidget {
  const BolsosCategoryMomo({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryTemplateMomo(
      categoryName: 'Bolsos',
      subcategories: [
        'Bolsos de mano',
        'Bolsos de hombro',
        'Mochilas',
        'Carteras',
      ],
    );
  }
}
