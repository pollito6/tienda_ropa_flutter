import 'package:flutter/material.dart';

class Category {
  final String name;
  final List<String> subcategories;
  final IconData icon;

  Category({
    required this.name,
    required this.subcategories,
    required this.icon,
  });
}

final List<Category> categories = [
  Category(
    name: 'Ropa',
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
    icon: Icons.checkroom,
  ),
  Category(
    name: 'Accesorios',
    subcategories: [
      'Sombreros',
      'Lentes',
      'Gorros',
      'Pendientes',
      'Relojes',
    ],
    icon: Icons.face, // Icono que representa una cara con sombrero/gorro
  ),
  Category(
    name: 'Calzado',
    subcategories: [
      'Botas',
      'Deportivos',
      'Flats',
      'Sandalias',
      'Tacones',
      'Tenis',
      'Zapatillas',
    ],
    icon: Icons.high_quality, // Icono que se parece a un tacón alto (forma de H con elevación)
  ),
  Category(
    name: 'Bolsos',
    subcategories: [
      'Bolsos de mano',
      'Mochilas',
      'Carteras',
      'Bolsos de hombro',
    ],
    icon: Icons.shopping_bag, // Icono de bolso
  ),
];
