import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/products_provider.dart';
import '/widgets/app_drawer.dart';
import '/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});

  static const String routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).getAllProducts;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, index) => UserProductItem(
            title: products[index].title,
            imageUrl: products[index].imageUrl,
          ),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
