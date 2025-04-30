import 'package:flutter/foundation.dart';
import '../models/product.dart';

/// Servicio que gestiona el historial de productos vistos
class HistoryService extends ChangeNotifier {
  // Singleton
  static final HistoryService _instance = HistoryService._internal();
  factory HistoryService() => _instance;
  HistoryService._internal();

  // Lista de productos vistos recientemente (el más reciente primero)
  final List<Product> _history = [];
  
  // Número máximo de productos a mantener en el historial
  final int _maxHistoryItems = 30;

  // Obtener todo el historial
  List<Product> get history => _history;

  // Agregar un producto al historial
  void addToHistory(Product product) {
    // Si el producto ya está en el historial, eliminarlo primero
    _history.removeWhere((p) => p.name == product.name);
    
    // Agregar el producto al principio de la lista (el más reciente)
    _history.insert(0, product);
    
    // Limitar el tamaño del historial
    if (_history.length > _maxHistoryItems) {
      _history.removeLast();
    }
    
    notifyListeners();
  }

  // Limpiar todo el historial
  void clearHistory() {
    _history.clear();
    notifyListeners();
  }

  // Eliminar un producto específico del historial
  void removeFromHistory(Product product) {
    _history.removeWhere((p) => p.name == product.name);
    notifyListeners();
  }
}
