import 'package:flutter/material.dart';
import 'screens/login_momo.dart';
import 'screens/home_momo.dart';
import 'screens/subcategory_momo.dart';
import 'screens/cart_momo.dart';
import 'screens/checkout_momo.dart';
import 'screens/favorites_momo.dart';
import 'screens/history_momo.dart';
import 'screens/account_momo.dart';
import 'screens/search_results_momo.dart';
import 'screens/categorias_momo.dart';
import 'theme/app_colors.dart';
import 'data/products.dart';

// Importar páginas de categoría
import 'screens/categories/ropa_category_momo.dart';
import 'screens/categories/accesorios_category_momo.dart';
import 'screens/categories/calzado_category_momo.dart';
import 'screens/categories/bolsos_category_momo.dart';

// Importar páginas de subcategoría para Ropa
import 'screens/subcategories/blusas_subcategory_momo.dart';
import 'screens/subcategories/faldas_subcategory_momo.dart';
import 'screens/subcategories/vestidos_subcategory_momo.dart';
import 'screens/subcategories/pantalones_subcategory_momo.dart';
import 'screens/subcategories/shorts_subcategory_momo.dart';
import 'screens/subcategories/lenceria_subcategory_momo.dart';
import 'screens/subcategories/calcetines_subcategory_momo.dart';
import 'screens/subcategories/pijamas_subcategory_momo.dart';

// Importar páginas de subcategoría para Accesorios
import 'screens/subcategories/sombreros_subcategory_momo.dart';
import 'screens/subcategories/lentes_subcategory_momo.dart';
import 'screens/subcategories/gorros_subcategory_momo.dart';

// Importar páginas de subcategoría para Calzado
import 'screens/subcategories/zapatillas_subcategory_momo.dart';

void main() {
  runApp(AppMoMo());
}

class AppMoMo extends StatelessWidget {
  const AppMoMo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoMo',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          tertiary: AppColors.tertiary,
          surface: AppColors.background,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginMomo(),
        '/home': (context) => HomeMomo(),
        '/category': (context) => CategoriasMomo(), // Removido 'const' para corregir lint error
        '/cart': (context) => CartMomo(),
        
        // Para mantener compatibilidad con el código existente
        '/subcategory': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return SubcategoryMomo(
            categoryName: args['category']!,
            subcategoryName: args['subcategory']!,
            products: products,
          );
        },
        
        '/favorites': (context) => const FavoritesMomo(),
        '/history': (context) => const HistoryMomo(),
        '/account': (context) => const AccountMomo(),
        '/checkout': (context) => const CheckoutMomo(),
        '/search': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return SearchResultsMomo(
            query: args['query']!,
          );
        },
        
        // Rutas para categorías
        '/category/ropa': (context) => const RopaCategoryMomo(),
        '/category/accesorios': (context) => const AccesoriosCategoryMomo(),
        '/category/calzado': (context) => const CalzadoCategoryMomo(),
        '/category/bolsos': (context) => const BolsosCategoryMomo(),
        
        // Rutas para subcategorías de Ropa
        '/subcategory/ropa/blusas': (context) => const BlusasSubcategoryMomo(),
        '/subcategory/ropa/faldas': (context) => const FaldasSubcategoryMomo(),
        '/subcategory/ropa/vestidos': (context) => const VestidosSubcategoryMomo(),
        '/subcategory/ropa/pantalones': (context) => const PantalonesSubcategoryMomo(),
        '/subcategory/ropa/shorts': (context) => const ShortsSubcategoryMomo(),
        '/subcategory/ropa/lenceria': (context) => const LenceriaSubcategoryMomo(),
        '/subcategory/ropa/calcetines': (context) => const CalcetinesSubcategoryMomo(),
        '/subcategory/ropa/pijamas': (context) => const PijamasSubcategoryMomo(),
        
        // Rutas para subcategorías de Accesorios
        '/subcategory/accesorios/sombreros': (context) => const SombrerosSubcategoryMomo(),
        '/subcategory/accesorios/lentes': (context) => const LentesSubcategoryMomo(),
        '/subcategory/accesorios/gorros': (context) => const GorrosSubcategoryMomo(),
        
        // Rutas para subcategorías de Calzado
        '/subcategory/calzado/zapatillas': (context) => const ZapatillasSubcategoryMomo(),
      },
    );
  }
}
