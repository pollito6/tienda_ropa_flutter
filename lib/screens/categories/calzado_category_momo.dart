import 'package:flutter/material.dart';
import '../../screens/category_template_momo.dart';

class CalzadoCategoryMomo extends StatelessWidget {
  const CalzadoCategoryMomo({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryTemplateMomo(
      categoryName: 'Calzado',
      subcategories: [
        'Zapatillas',
        'Sandalias',
        'Botas',
      ],
    );
  }
}
