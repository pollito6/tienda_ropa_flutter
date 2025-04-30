import 'package:flutter/material.dart';
import '../../screens/category_template_momo.dart';

class RopaCategoryMomo extends StatelessWidget {
  const RopaCategoryMomo({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoryTemplateMomo(
      categoryName: 'Ropa',
      subcategories: [
        'Blusas',
        'Faldas',
        'Conjuntos',
        'Vestidos',
        'Pantalones',
        'Shorts',
        'Lencería',
        'Calcetines',
        'Pijamas',
      ],
    );
  }
}
