import 'package:flutter/material.dart';
import 'package:shopping/widgets/product_item.dart';

import '../models/product.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = [
    Product(
      id: 'p1',
      title: 'Apple iPhone 14 Pro Max 256GB Green',
      description: 'A red shirt - it is pretty red!',
      price: 1029.95,
      imageUrl:
          'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80',
    ),
    Product(
      id: 'p2',
      title:
          'Wahl Clipper Oil 120ml - Lubricating Oil for Clippers, Scissors & Shears',
      description: 'A nice pair of trousers.',
      price: 23.50,
      imageUrl:
          'https://images.unsplash.com/photo-1600493570893-3d5c65dce3c5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.45,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.90,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  ProductOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SafiTree")),
      body: GridView.builder(
        // shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio:
              MediaQuery.of(context).size.width / ProductItem.imageHeight,
        ),
        itemBuilder: ((context, index) => ProductItem(
              id: loadedProducts[index].id,
              title: loadedProducts[index].title,
              description: loadedProducts[index].description,
              price: loadedProducts[index].price,
              imageUrl: loadedProducts[index].imageUrl,
            )),
        padding: const EdgeInsets.all(5),
        itemCount: loadedProducts.length,
      ),
    );
  }
}
