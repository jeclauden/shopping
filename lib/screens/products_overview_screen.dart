import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/cart.dart';
import 'package:shopping/screens/cart_screen.dart';
import 'package:shopping/screens/orders_screen.dart';
import 'package:shopping/widgets/badge.dart';

import '../widgets/app_drawer.dart';
import '../widgets/products_list.dart';

enum MenuItem {
  all,
  favorite,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("SafiTree"),
        actions: [
          PopupMenuButton<MenuItem>(
            onSelected: (selectionMenu) {
              setState(() {
                if (selectionMenu == MenuItem.favorite) {
                  //...
                  _showFavoritesOnly = true;
                } else {
                  //...
                  _showFavoritesOnly = false;
                }
              });
            },
            itemBuilder: ((_) => <PopupMenuEntry<MenuItem>>[
                  const PopupMenuItem<MenuItem>(
                    value: MenuItem.all,
                    child: Text("Show All Products"),
                  ),
                  const PopupMenuItem<MenuItem>(
                    value: MenuItem.favorite,
                    child: Text("Show Favorites Only"),
                  ),
                ]),
            icon: const Icon(Icons.more_vert),
          ),
          // Cart Consumer
          Consumer<Cart>(
            builder: (_, cart, cld) => Badge(
              value: cart.getTotalItems.toString(),
              child: cld!, // cld will never be null
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      body: ProductsList(
        showFavoritesOnly: _showFavoritesOnly,
      ),
    );
  }
}
