import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MenuMomo extends StatelessWidget {
  const MenuMomo({super.key});
  
  // Método auxiliar para normalizar cadenas (quitar acentos y convertir a minúsculas)
  String _normalizeString(String text) {
    // Tabla de equivalencias para caracteres acentuados
    final replacements = {
      'á': 'a', 'é': 'e', 'í': 'i', 'ó': 'o', 'ú': 'u',
      'Á': 'A', 'É': 'E', 'Í': 'I', 'Ó': 'O', 'Ú': 'U',
      'ñ': 'n', 'Ñ': 'N',
    };
    
    String normalized = text.toLowerCase();
    
    // Reemplazar caracteres acentuados
    replacements.forEach((key, value) {
      normalized = normalized.replaceAll(key, value);
    });
    
    return normalized;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Header con logo o imagen de la marca
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              decoration: BoxDecoration(
                color: AppColors.primary,
              ),
              height: 100, // Altura para el header
              width: double.infinity,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // Usar un enfoque más seguro para la navegación
                    final route = '/category';
                    
                    // Primero cerrar el drawer 
                    Navigator.pop(context);
                    
                    // Luego navegar usando un callback en el siguiente frame
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushNamed(context, route);
                    });
                  },
                  child: Text(
                    'CATEGORÍAS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10), // Espacio después del header
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8),
                children: [
                  // Ropa y sus subcategorías
                  _buildCategoryHeader(context, 'Ropa'),
                  _buildSubcategoryList(context, 'Ropa', [
                    'Blusas', 'Faldas', 'Conjuntos', 'Vestidos',
                    'Pantalones', 'Shorts', 'Lencería', 'Calcetines', 'Pijamas'
                  ]),
                  
                  // Accesorios y sus subcategorías
                  _buildCategoryHeader(context, 'Accesorios'),
                  _buildSubcategoryList(context, 'Accesorios', [
                    'Sombreros', 'Lentes', 'Gorros'
                  ]),
                  
                  // Calzado y sus subcategorías
                  _buildCategoryHeader(context, 'Calzado'),
                  _buildSubcategoryList(context, 'Calzado', [
                    'Zapatillas', 'Sandalias', 'Botas'
                  ]),
                  
                  // Bolsos como categoría principal, igual que las otras categorías
                  _buildCategoryHeader(context, 'Bolsos'),
                  _buildSubcategoryList(context, 'Bolsos', [
                    'Bolsos de mano', 'Mochilas', 'Carteras', 'Bolsos de hombro'
                  ]),
                  
                  Divider(height: 32),
                  
                  // Opciones adicionales
                  ListTile(
                    leading: Icon(Icons.category, color: AppColors.primary),
                    title: Text(
                      'Categorías',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      // Usar un enfoque más seguro para la navegación
                      final route = '/category';
                      
                      // Primero cerrar el drawer
                      Navigator.pop(context);
                      
                      // Luego navegar usando un callback en el siguiente frame
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushNamed(context, route);
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person_outline, color: AppColors.primary),
                    title: Text(
                      'Mi Cuenta',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite_border, color: AppColors.primary),
                    title: Text(
                      'Favoritos',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_bag_outlined, color: AppColors.primary),
                    title: Text(
                      'Mis Compras',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app, color: AppColors.primary),
                    title: Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(BuildContext context, String title) {
    // Asegurarse de que el nombre de la categoría coincida exactamente con las rutas definidas en main.dart
    String categoryPath;
    
    // Usar exactamente el mismo formato que en las rutas registradas en main.dart
    if (title == 'Ropa') {
      categoryPath = 'ropa';
    } else if (title == 'Accesorios') {
      categoryPath = 'accesorios';
    } else if (title == 'Calzado') {
      categoryPath = 'calzado';
    } else if (title == 'Bolsos') {
      categoryPath = 'bolsos';
    } else {
      // Fallback en caso de que se use una categoría no reconocida
      categoryPath = title.toLowerCase();
    }
    
    return Container(
      padding: EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: InkWell(
        onTap: () {
          // Utilizar una navegación más directa para mejor compatibilidad con web
          print('Navegando a categoría: $categoryPath');
          
          // Guardar la ruta antes de cerrar el drawer
          final route = '/category/$categoryPath';
          
          // Cerrar el drawer primero
          Navigator.pop(context);
          
          // Luego navegar usando un callback en el siguiente frame
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(context, route);
          });
        },
        child: Row(
          children: [
            Text(
              title.toUpperCase(),
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubcategoryList(BuildContext context, String category, List<String> subcategories) {
    return Column(
      children: subcategories.map((subcategory) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 32),
        title: Text(
          subcategory,
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 14,
          ),
        ),
        onTap: () {
          // Asegurar que los nombres de categoría coincidan exactamente
          String categoryPath;
          if (category == 'Ropa') {
            categoryPath = 'ropa';
          } else if (category == 'Accesorios') {
            categoryPath = 'accesorios';
          } else if (category == 'Calzado') {
            categoryPath = 'calzado';
          } else if (category == 'Bolsos') {
            categoryPath = 'bolsos';
          } else {
            categoryPath = category.toLowerCase();
          }
          
          // Normalizar subcategoría
          String subcategoryPath = _normalizeString(subcategory);
          
          // Para 'Lencería', usar manualmente 'lenceria' (sin acento) para que coincida con la ruta
          if (subcategory == 'Lencería') {
            subcategoryPath = 'lenceria';
          }
          
          print('Navegando a subcategoría: $categoryPath/$subcategoryPath');
          
          // Guardar la ruta antes de cerrar el drawer
          final route = '/subcategory/$categoryPath/$subcategoryPath';
          
          // Cerrar el drawer primero
          Navigator.pop(context);
          
          // Luego navegar usando un callback en el siguiente frame
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(context, route);
          });
        },
      )).toList(),
    );
  }
}
