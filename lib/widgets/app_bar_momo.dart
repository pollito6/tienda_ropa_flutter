import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Barra superior de la app MoMo con logo, buscador, carrito y menú.
/// Ahora es `StatefulWidget` para mantener un `TextEditingController` y hacer
/// la búsqueda totalmente funcional (al presionar *Enter* o tocar el icono de
/// lupa). El ancho del buscador es 55 % del ancho de pantalla para generar
/// mayor espaciado entre el `IconButton` de carrito y la barra.

class AppBarMomo extends StatefulWidget implements PreferredSizeWidget {
  const AppBarMomo({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<AppBarMomo> createState() => _AppBarMomoState();
}

class _AppBarMomoState extends State<AppBarMomo> {
  final TextEditingController _controller = TextEditingController();

  void _launchSearch(String value) {
    final query = value.trim();
    if (query.isNotEmpty) {
      Navigator.pushNamed(context, '/search', arguments: {'query': query});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: AppColors.tertiary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/home');
              },
              child: Image.asset('assets/images/momo_isotipo.png', height: 50),
            ),
            const Spacer(),
            // Buscador expandible
            Expanded(
              flex: 7,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Buscar productos...',
                    hintStyle: TextStyle(
                      color: AppColors.secondary.withAlpha(50),
                      fontSize: 14,
                    ),
                    // Solo un icono de búsqueda al final
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: AppColors.primary, size: 20),
                      onPressed: () => _launchSearch(_controller.text),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                  ),
                  onSubmitted: _launchSearch,
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.primary,
                size: 28,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
            ),
            SizedBox(width: 8),
            Builder(
              builder: (context) => IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: Icon(
                  Icons.menu,
                  color: AppColors.primary,
                  size: 28,
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
