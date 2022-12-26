import 'package:flutter/material.dart';
import 'package:shopping/providers/products_provider.dart';

import '../providers/product_provider.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';

class ProductsList extends StatelessWidget {
  final showFavoritesOnly;
  const ProductsList({
    Key? key,
    required this.showFavoritesOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using Provider
    final products = showFavoritesOnly
        ? Provider.of<ProductsProvider>(context).getFavoriteProducts
        : Provider.of<ProductsProvider>(context).getAllProducts;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio:
            MediaQuery.of(context).size.width / ProductItem.imageHeight,
      ),
      itemBuilder: ((context, index) => ChangeNotifierProvider.value(
            // Use .value if using existing objects
            value: products[index], // products are a list of Product provider
            child: const ProductItem(),
          )),
      padding: const EdgeInsets.all(5),
      itemCount: products.length,
    );
  }
}
