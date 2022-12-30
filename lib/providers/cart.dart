import 'package:flutter/material.dart';

class CartProduct with ChangeNotifier {
  final String id;
  final String title;
  int quantity = 1;
  final double price;
  double totalPrice = 0.0;

  CartProduct({
    required this.id,
    required this.title,
    required this.price,
  });

  void updateQuantity(int newQuantity) {
    quantity = newQuantity;
    totalPrice = price * quantity;
    notifyListeners();
  }

  void incrementQuantity() {
    quantity++;
    totalPrice = price * quantity;
    notifyListeners();
  }
}

class Cart with ChangeNotifier {
  final Map<String, CartProduct> _items = {};

  Map<String, CartProduct> get items {
    return {..._items};
  }

  List<CartProduct> get getCartProducts {
    return _items.values.toList();
  }

  void addItem(String productId, double price, String title) {
    final CartProduct p = CartProduct(
      id: productId,
      title: title,
      price: price,
    );

    p.totalPrice = price;

    _items.putIfAbsent(
      productId,
      () => p,
    );

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void updateCartItem(String productId, int newQuantity) {
    if (_items.keys.contains(productId)) {
      CartProduct p = _items[productId]!;
      p.updateQuantity(newQuantity);
      notifyListeners();
    }
  }

  int get getTotalItems {
    var totalItems = 0;
    _items.forEach((key, value) {
      totalItems += value.quantity;
    });
    return totalItems;
  }

  double getTotalCost() {
    double totalCost = 0.0;
    _items.forEach((key, value) {
      totalCost += value.totalPrice;
    });
    return totalCost;
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
