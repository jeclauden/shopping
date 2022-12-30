import 'package:flutter/material.dart';

import '../providers/cart.dart';
import 'cart_item.dart';
import 'package:provider/provider.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using Provider
    final cartProducts = Provider.of<Cart>(context).getCartProducts;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: MediaQuery.of(context).size.width / 200,
      ),
      itemBuilder: ((context, index) => ChangeNotifierProvider.value(
            // Use .value if using existing objects
            value:
                cartProducts[index], // products are a list of Product provider
            child: CartItem(),
          )),
      padding: const EdgeInsets.all(5),
      itemCount: cartProducts.length,
    );
  }
}
