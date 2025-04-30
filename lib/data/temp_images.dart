// Archivo temporal para usar imágenes de ejemplo mientras se suben las imágenes reales

import '../models/product.dart';

const String defaultProductImage = 'assets/images/momo_logo_4x.png';
const String assetPrefix = 'assets/';

/// Función para resolver la ruta correcta de la imagen de un producto
String getProductImagePath(Product product) {
  try {
    // Capturar información inicial para debugging
    final name = product.name;
    final category = product.category;
    final subcategory = product.subcategory;
    final imageUrl = product.imageUrl;
    
    print('DEBUG: Resolviendo ruta para: $name, Categoría: $category, Subcategoría: $subcategory');
    
    // Construir la ruta basada en la categoría
    String path;
    
    // Normalizar categoría con primera letra mayúscula
    String normalizedCategory = '';
    if (category.isNotEmpty) {
      normalizedCategory = category[0].toUpperCase() + category.substring(1).toLowerCase();
    }
    
    // Manejar cada categoría con sus particularidades
    switch (normalizedCategory) {
      case 'Accesorios':
        // Subcategorías con primera letra mayúscula
        String formattedSubcat = '';
        if (subcategory.isNotEmpty) {
          formattedSubcat = subcategory[0].toUpperCase() + subcategory.substring(1).toLowerCase();
        }
        
        // Verificar subcategorías válidas
        if (['Sombreros', 'Lentes', 'Gorros'].contains(formattedSubcat)) {
          path = 'assets/images/Accesorios/$formattedSubcat/$imageUrl';
        } else {
          print('DEBUG: Subcategoría de accesorios no reconocida: $subcategory');
          return defaultProductImage;
        }
        break;
        
      case 'Bolsos':
        // Imágenes directamente en la carpeta principal
        path = 'assets/images/Bolsos/$imageUrl';
        break;
        
      case 'Calzado':
        // Subcategorías con primera letra mayúscula
        String formattedSubcat = '';
        if (subcategory.isNotEmpty) {
          formattedSubcat = subcategory[0].toUpperCase() + subcategory.substring(1).toLowerCase();
        }
        
        // Verificar subcategorías válidas
        if (['Botas', 'Sandalias', 'Zapatillas'].contains(formattedSubcat)) {
          path = 'assets/images/Calzado/$formattedSubcat/$imageUrl';
        } else {
          print('DEBUG: Subcategoría de calzado no reconocida: $subcategory');
          return defaultProductImage;
        }
        break;
        
      case 'Ropa':
        // Las subcarpetas de Ropa están en minúsculas
        String formattedSubcat = subcategory.toLowerCase();
        
        // Manejo especial para Lencería
        if (subcategory == 'Lencería') {
          formattedSubcat = 'lenceria';
        }
        
        path = 'assets/images/Ropa/$formattedSubcat/$imageUrl';
        break;
        
      default:
        // Categoría desconocida
        print('DEBUG: Categoría desconocida: $normalizedCategory');
        return defaultProductImage;
    }
    
    print('DEBUG: Intentando cargar imagen desde: $path');
    return path;
  } catch (e) {
    print('Error al construir la ruta de la imagen: $e');
    return defaultProductImage;
  }
}
