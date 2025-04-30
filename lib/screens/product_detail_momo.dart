import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../widgets/app_bar_momo.dart';
import '../data/temp_images.dart';
import '../services/history_service.dart';
import '../services/cart_service.dart';
import '../widgets/favorite_button.dart';

class ProductDetailMomo extends StatefulWidget {
  final Product product;

  const ProductDetailMomo({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailMomo> createState() => _ProductDetailMomoState();
}

class _ProductDetailMomoState extends State<ProductDetailMomo> {
  final HistoryService _historyService = HistoryService();
  final CartService _cartService = CartService();
  int _quantity = 1; // Cantidad predeterminada para agregar al carrito

  @override
  void initState() {
    super.initState();
    // Agregar este producto al historial cuando se abre la página
    _historyService.addToHistory(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMomo(),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto con zoom en tap
            GestureDetector(
              onTap: () {
                // Mostrar imagen ampliada al hacer tap
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: EdgeInsets.all(10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        InteractiveViewer(
                          panEnabled: true,
                          minScale: 0.5,
                          maxScale: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.asset(
                              getProductImagePath(widget.product),
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  defaultProductImage,
                                  fit: BoxFit.contain,
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  Hero(
                    tag: 'product-${widget.product.name}',
                    child: Container(
                      width: double.infinity,
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        getProductImagePath(widget.product),
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error cargando imagen: ${getProductImagePath(widget.product)}');
                          return Image.asset(
                            defaultProductImage,
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),
                  ),
                  // Indicador de zoom
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.zoom_in, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Ampliar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Botón de favoritos mejorado
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FavoriteButton(product: widget.product),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Información del producto
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Etiquetas de categoría
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildCategoryChip(widget.product.category),
                      _buildCategoryChip(widget.product.subcategory),
                    ],
                  ),
                  SizedBox(height: 16),
                  
                  // Descripción
                  Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Detalles adicionales
                  ExpansionTile(
                    title: Text(
                      'Detalles del producto',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow('Categoría', widget.product.category),
                            SizedBox(height: 8),
                            _buildDetailRow('Subcategoría', widget.product.subcategory),
                            SizedBox(height: 8),
                            _buildDetailRow('SKU', 'MO-${widget.product.name.substring(0, 3).toUpperCase()}-${widget.product.price.toInt()}'),
                            SizedBox(height: 8),
                            _buildDetailRow('Material', 'Premium'),
                            SizedBox(height: 8),
                            _buildDetailRow('Envío', 'Gratis en compras mayores a \$999'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  // Selector de cantidad
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Cantidad:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 20),
                      _buildQuantityButton(
                        icon: Icons.remove,
                        onPressed: () {
                          setState(() {
                            if (_quantity > 1) _quantity--;
                          });
                        },
                      ),
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(
                          '$_quantity',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _buildQuantityButton(
                        icon: Icons.add,
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Botón de agregar al carrito
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Agregar el producto al carrito con la cantidad seleccionada
                        _cartService.addToCart(widget.product, quantity: _quantity);
                        
                        // Mostrar mensaje de confirmación
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${widget.product.name} agregado al carrito (${_quantity}x)'),
                            backgroundColor: AppColors.primary,
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                              label: 'VER CARRITO',
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, '/cart');
                              },
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Agregar al Carrito - \$${(widget.product.price * _quantity).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Botón para incrementar/decrementar cantidad
  Widget _buildQuantityButton({required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 16, color: AppColors.primary),
      ),
    );
  }
  
  // Chip para mostrar categoría/subcategoría
  Widget _buildCategoryChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.primary,
        ),
      ),
    );
  }
  
  // Fila para detalles del producto
  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
