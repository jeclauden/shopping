import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product-detail";
  const ProductDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Using route
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    // Using Provider
    final product = Provider.of<ProductsProvider>(
      context,
      listen:
          false, // It's not necessary to rebuild the detail screen if products change. No need to listern
    ).findProductById(productId);

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
    );
  }
}
