import 'package:flutter/material.dart';
import 'package:shopping/providers/cart.dart';

import '../widgets/app_utility.dart';

class Order with ChangeNotifier {
  final String id;
  final double amount;
  final List<CartProduct> products;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<CartProduct> products, double totalAmount) {
    _orders.insert(
      0,
      Order(
        id: AppUtility().createOrderId(),
        amount: totalAmount,
        products: products,
        dateTime: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  Order getOrderById(String id) {
    return _orders.firstWhere((order) => order.id == id);
  }
}
