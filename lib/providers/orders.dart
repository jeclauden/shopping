import 'package:flutter/material.dart';
import 'package:shopping/providers/cart.dart';
import 'dart:math';

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

const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );

class Orders with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<CartProduct> products, double totalAmount) {
    _orders.insert(
      0,
      Order(
        id: getRandomString(10),
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
