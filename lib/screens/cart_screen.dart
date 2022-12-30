import 'package:flutter/material.dart';
import 'package:shopping/providers/orders.dart';
import 'package:shopping/widgets/cart_items_list.dart';

import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart-screen';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Your shopping cart")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    const Text(
                      "Total: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.getTotalCost().toStringAsFixed(2)}',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        // final cart = Provider.of<Cart>(context);
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.getCartProducts, cart.getTotalCost());

                        cart.clearCart();
                      },
                      child: const Text("ORDER NOW"),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: CartItemsList(),
          ),
        ],
      ),
    );
  }
}
