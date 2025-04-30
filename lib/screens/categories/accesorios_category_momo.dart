import 'package:flutter/material.dart';
import '../../screens/category_template_momo.dart';

class AccesoriosCategoryMomo extends StatelessWidget {
  const AccesoriosCategoryMomo({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryTemplateMomo(
      categoryName: 'Accesorios',
      subcategories: [
        'Sombreros',
        'Lentes',
        'Gorros',
      ],
    );
  }
}
