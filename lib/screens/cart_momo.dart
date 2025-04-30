import 'package:flutter/material.dart';
import '../widgets/app_bar_momo.dart';
import '../widgets/menu_momo.dart';
import '../theme/app_colors.dart';
import '../services/cart_service.dart';
import '../data/temp_images.dart';
import '../models/product.dart';
import '../screens/checkout_momo.dart';
import '../screens/product_detail_momo.dart';

class CartMomo extends StatefulWidget {
  const CartMomo({super.key});

  @override
  State<CartMomo> createState() => _CartMomoState();
}

class _CartMomoState extends State<CartMomo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    // Escuchar cambios en el servicio de carrito para actualizar la UI
    _cartService.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    
    // Para fines de prueba, añadir productos al carrito si está vacío
    if (_cartService.cartItems.isEmpty) {
      // Agregar varios productos para probar la interfaz
      if (demoProducts.length >= 3) {
        _cartService.addToCart(demoProducts[0]);
        _cartService.addToCart(demoProducts[1]);
        _cartService.addToCart(demoProducts[2]);
      } else if (demoProducts.isNotEmpty) {
        _cartService.addToCart(demoProducts[0]);
      }
    }
  }
  
  @override
  void dispose() {
    // Remover listener al destruir el widget
    _cartService.removeListener(() {});
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarMomo(),
      endDrawer: MenuMomo(),
      backgroundColor: AppColors.background,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 51),
              blurRadius: 5,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: BottomAppBar(
          color: AppColors.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home_outlined, color: Colors.white, size: 28),
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.white, size: 28),
                onPressed: () => Navigator.pushReplacementNamed(context, '/favorites'),
              ),
              IconButton(
                icon: Icon(Icons.history, color: Colors.white, size: 28),
                onPressed: () => Navigator.pushReplacementNamed(context, '/history'),
              ),
              IconButton(
                icon: Icon(Icons.person_outline, color: Colors.white, size: 28),
                onPressed: () => Navigator.pushReplacementNamed(context, '/account'),
              ),
            ],
          ),
        ),
      ),
      body: _cartContent(),
      // Botón flotante de pago que aparece cuando hay items
      floatingActionButton: _cartService.cartItems.isNotEmpty
          ? _buildCheckoutButton()
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  
  // Botón flotante para proceder al pago
  Widget _buildCheckoutButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: FloatingActionButton.extended(
        onPressed: () {
          // Navegar a la pantalla de checkout y refrescar estado cuando regrese
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CheckoutMomo()),
          ).then((value) {
            // Refrescar para captar cambios después de volver del checkout
            setState(() {});
          });
        },
        backgroundColor: AppColors.primary,
        elevation: 4,
        label: Row(
          children: [
            Text(
              'Proceder al pago',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '\$${_cartService.total.toStringAsFixed(2)}',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        icon: Icon(Icons.shopping_cart_checkout),
        isExtended: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
  
  // Contenido principal del carrito (cambia según si está vacío o no)
  Widget _cartContent() {
    // Obtener items del carrito
    final cartItems = _cartService.cartItems;
    
    // Si el carrito está vacío
    if (cartItems.isEmpty) {
      return _buildEmptyCart();
    }
    
    // Si hay productos en el carrito
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 96), // Añadir padding inferior para el botón de checkout
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título de la página con botón de limpiar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mi Carrito',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              if (cartItems.isNotEmpty)
                TextButton.icon(
                  onPressed: () {
                    // Mostrar diálogo de confirmación
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Vaciar carrito'),
                        content: Text('¿Estás seguro que deseas eliminar todos los productos del carrito?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _cartService.clearCart();
                              });
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: Text('Vaciar carrito'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  label: Text(
                    'Vaciar',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16),
            
          // Lista de productos en el carrito - Ahora como ListView.separated para mejor separación
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cartItems.length,
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemBuilder: (context, index) => _buildCartItem(cartItems[index]),
          ),
            
          // Resumen del carrito
          SizedBox(height: 20),
          Card(
            elevation: 2,
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildPriceSummary(),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para un elemento del carrito
  Widget _buildCartItem(CartItem item) {
    return GestureDetector(
      onTap: () {
        // Navegar a detalles del producto
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailMomo(
              product: item.product,
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Imagen del producto
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  getProductImagePath(item.product),
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print('Error cargando imagen: ${getProductImagePath(item.product)}');
                    return Image.asset(
                      defaultProductImage,
                      width: 90,
                      height: 90,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.product.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    
                    // Categoría y subcategoría
                    Text(
                      '${item.product.category} - ${item.product.subcategory}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6),
                    
                    // Precio unitario
                    Text(
                      'Precio: \$${item.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondary,
                      ),
                    ),
                    SizedBox(height: 8),
                    
                    // Contador de cantidad
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildQuantityButton(
                          icon: Icons.remove,
                          onPressed: () {
                            setState(() {
                              _cartService.decreaseQuantity(item.product);
                            });
                          },
                        ),
                        Container(
                          width: 32,
                          alignment: Alignment.center,
                          child: Text(
                            '${item.quantity}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildQuantityButton(
                          icon: Icons.add,
                          onPressed: () {
                            setState(() {
                              _cartService.increaseQuantity(item.product);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Botón de eliminar y precio total
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Botón eliminar
                  Tooltip(
                    message: 'Eliminar del carrito',
                    child: InkWell(
                      onTap: () {
                        // Confirmar eliminación
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Eliminar producto'),
                            content: Text('¿Quieres eliminar este producto del carrito?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancelar'),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _cartService.removeFromCart(item.product);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('Eliminar'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 51), // Mayor opacidad para mejor contraste
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red.withValues(alpha: 102), width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 38),
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 20, // Ligeramente más grande
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Precio total del ítem
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary, // Color sólido para mejor contraste
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 38),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      'Total: \$${item.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Texto blanco para contraste con fondo oscuro
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
  
  // Widget para mostrar el resumen de precios
  Widget _buildPriceSummary() {
    return Column(
      children: [
        // Subtotal
        _buildPriceRow('Subtotal', _cartService.subtotal),
        SizedBox(height: 4),
        
        // IVA
        _buildPriceRow('IVA (16%)', _cartService.tax),
        SizedBox(height: 4),
        
        // Envío
        _buildPriceRow(
          'Envío', 
          _cartService.shipping,
          info: _cartService.shipping > 0 
              ? '(Gratis a partir de \$999)'
              : '(Gratis)',
        ),
        
        Divider(height: 16),
        
        // Total
        _buildPriceRow(
          'Total', 
          _cartService.total,
          isTotal: true,
        ),
      ],
    );
  }
  
  // Fila individual del resumen de precios
  Widget _buildPriceRow(String label, double value, {String? info, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Etiqueta
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? AppColors.primary : Colors.black87,
              ),
            ),
            if (info != null)
              Text(
                ' $info',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
        
        // Valor
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppColors.primary : Colors.black87,
          ),
        ),
      ],
    );
  }

  // Widget para mostrar el carrito vacío
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: AppColors.primary,
          ),
          SizedBox(height: 20),
          Text(
            'Tu carrito está vacío',
            style: TextStyle(
              fontSize: 24,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Agrega productos para comenzar',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.secondary,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: Text(
              'Ir a comprar',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
