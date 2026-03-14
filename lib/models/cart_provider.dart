import 'package:flutter/material.dart';
import 'product.dart';

// Basit sepet yönetimi - ChangeNotifier ile
class CartProvider extends ChangeNotifier {
  // Singleton - her yerden erişebilmek için
  static final CartProvider instance = CartProvider._internal();
  CartProvider._internal();

  final List<Product> _items = [];

  List<Product> get items => _items;

  int get itemCount => _items.length;

  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += item.price;
    }
    return total;
  }

  void addItem(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  bool isInCart(Product product) {
    return _items.any((item) => item.id == product.id);
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
