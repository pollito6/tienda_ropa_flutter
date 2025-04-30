import 'package:flutter/foundation.dart';
import '../models/product.dart';

/// Modelo para representar un elemento en el carrito
class CartItem {
  final Product product;
  int quantity;
  
  CartItem({
    required this.product,
    this.quantity = 1,
  });
  
  // Obtener el precio total de este ítem
  double get totalPrice => product.price * quantity;
}

/// Servicio que gestiona los productos en el carrito
class CartService extends ChangeNotifier {
  // Singleton
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  // Lista de productos en el carrito
  final List<CartItem> _cartItems = [];
  
  // Obtener todos los items del carrito
  List<CartItem> get cartItems => _cartItems;
  
  // Obtener el total de productos en el carrito
  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  
  // Obtener el subtotal del carrito
  double get subtotal => _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  
  // Obtener el IVA (16%)
  double get tax => subtotal * 0.16;
  
  // Obtener el envío (fijo a 99.00 si el subtotal es menor a 999, gratis si es mayor)
  double get shipping => subtotal < 999 ? 99.0 : 0.0;
  
  // Obtener el total a pagar
  double get total => subtotal + tax + shipping;
  
  // Verificar si un producto está en el carrito
  bool isInCart(Product product) {
    return _cartItems.any((item) => item.product.name == product.name);
  }
  
  // Obtener un item del carrito por producto
  CartItem? getCartItem(Product product) {
    try {
      return _cartItems.firstWhere((item) => item.product.name == product.name);
    } catch (e) {
      return null;
    }
  }
  
  // Agregar un producto al carrito
  void addToCart(Product product, {int quantity = 1}) {
    // Si el producto ya está en el carrito, aumentar la cantidad
    if (isInCart(product)) {
      increaseQuantity(product, byAmount: quantity);
    } else {
      // Si no, agregarlo
      _cartItems.add(CartItem(
        product: product,
        quantity: quantity,
      ));
      notifyListeners();
    }
  }
  
  // Quitar un producto del carrito
  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.product.name == product.name);
    notifyListeners();
  }
  
  // Aumentar la cantidad de un producto
  void increaseQuantity(Product product, {int byAmount = 1}) {
    final cartItem = getCartItem(product);
    if (cartItem != null) {
      cartItem.quantity += byAmount;
      notifyListeners();
    }
  }
  
  // Disminuir la cantidad de un producto
  void decreaseQuantity(Product product) {
    final cartItem = getCartItem(product);
    if (cartItem != null) {
      if (cartItem.quantity > 1) {
        cartItem.quantity--;
      } else {
        removeFromCart(product);
      }
      notifyListeners();
    }
  }
  
  // Limpiar todo el carrito
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
