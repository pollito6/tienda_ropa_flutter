import 'package:flutter/material.dart';
import '../services/history_service.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../data/temp_images.dart';
import '../screens/product_detail_momo.dart';
import '../widgets/app_nav.dart';
import '../widgets/app_bar_momo.dart';
import '../widgets/menu_momo.dart';

class HistoryMomo extends StatefulWidget {
  const HistoryMomo({super.key});

  @override
  State<HistoryMomo> createState() => _HistoryMomoState();
}

class _HistoryMomoState extends State<HistoryMomo> {
  final HistoryService _historyService = HistoryService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Obtener lista de historial
    final List<Product> historyItems = _historyService.history;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarMomo(),
      endDrawer: MenuMomo(),
      backgroundColor: AppColors.background,
      bottomNavigationBar: AppNav(
        currentIndex: 2, // Índice 2 corresponde a Historial
        onTap: (index) {
          switch (index) {
            case 0: // Home
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1: // Favoritos
              Navigator.pushReplacementNamed(context, '/favorites');
              break;
            case 2: // Historial
              // Ya estamos en Historial
              break;
            case 3: // Cuenta
              Navigator.pushNamed(context, '/account');
              break;
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título de la sección
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Historial',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                if (historyItems.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      // Mostrar diálogo de confirmación
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Limpiar historial'),
                            content: Text('¿Estás seguro de que quieres eliminar todo tu historial?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _historyService.clearHistory();
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Eliminar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'Limpiar todo',
                      style: TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16),
            
            // Mensaje si no hay historial
            if (historyItems.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        size: 80,
                        color: AppColors.primary.withValues(alpha: 0.5),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No hay historial',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Los productos que visualices aparecerán aquí',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text('Explorar productos'),
                      ),
                    ],
                  ),
                ),
              )
            else
              // Lista cronológica de productos visitados
              Expanded(
                child: ListView.builder(
                  itemCount: historyItems.length,
                  itemBuilder: (context, index) {
                    final product = historyItems[index];
                    // Usar Dismissible para permitir deslizar para quitar del historial
                    return Dismissible(
                      key: Key(product.name),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          _historyService.removeFromHistory(product);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} eliminado del historial'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: _buildHistoryItem(context, product),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, Product product) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailMomo(
                product: product,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Imagen del producto
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  getProductImagePath(product),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print('Error cargando imagen: ${getProductImagePath(product)}');
                    return Image.asset(
                      defaultProductImage,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(width: 12),
              // Información del producto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${product.category} > ${product.subcategory}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Icono de flecha
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.secondary,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
