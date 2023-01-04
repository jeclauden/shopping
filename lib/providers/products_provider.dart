import 'package:flutter/material.dart';
import 'product_provider.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p2',
      title:
          'Wahl Clipper Oil 120ml - Lubricating Oil for Clippers, Scissors & Shears',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
      price: 23.50,
      imageUrl:
          'https://images.unsplash.com/photo-1600493570893-3d5c65dce3c5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80',
    ),
    Product(
      id: 'p1',
      title: 'Apple iPhone 14 Pro Max 256GB Green',
      description: 'A red shirt - it is pretty red!',
      price: 1029.95,
      imageUrl:
          'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80',
    ),
    Product(
      id: 'p3',
      title: 'Ikanzu Yera kandi imeze neza cane. Karibu sana',
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

  // Must return a copy not the actual list
  List<Product> get getAllProducts {
    return [..._items];
  }

  String getImageUrl(String id) {
    final Product p = _items.firstWhere((prod) => prod.id == id);
    return p.imageUrl;
  }

  // Return of copy of the list of favorite products
  List<Product> get getFavoriteProducts {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  void addProduct(Product product) {
    final newProduct = Product(
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    notifyListeners();
  }

  Product findProductById(String productId) {
    return _items.firstWhere((prod) => prod.id == productId);
  }

  void updateProduct(Product product) {
    final productIndex = _items.indexWhere((prod) => prod.id == product.id);
    _items[productIndex] = product;
    notifyListeners();
  }

  void removeProduct(String productId) {
    _items.removeWhere(
      (prod) => prod.id == productId,
    );
    notifyListeners();
  }
}
