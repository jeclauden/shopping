import 'package:flutter/material.dart';
import 'package:shopping/widgets/app_drawer.dart';
import 'package:shopping/widgets/orders_list.dart';

class OrdersSreen extends StatelessWidget {
  static const String routeName = '/orders-screen';
  const OrdersSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(title: const Text("Your orders")),
      body: const OrdersList(),
    );
  }
}
