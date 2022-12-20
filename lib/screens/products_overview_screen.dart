import 'package:flutter/material.dart';

import '../widgets/products_list.dart';

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SafiTree")),
      body: const ProductsList(),
    );
  }
}
