import 'package:flutter/material.dart';
import 'package:shopping/providers/cart.dart';
import 'package:shopping/providers/products_provider.dart';
import 'package:shopping/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  static const double cornerDoundness = 3;
  static const double imageHeight = 140;
  static const double imageWidth = 140;
  static const String imageUrl =
      'https://images.unsplash.com/photo-1600493570893-3d5c65dce3c5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80';

  final _controller = TextEditingController();
  CartItem({
    super.key,
  });

  TextEditingController getController(String quantity) {
    _controller.text = quantity;
    return _controller;
  }

  TextButton _removeItem(BuildContext context, Cart cart, String id) =>
      TextButton(
        child: const Text("Remove"),
        onPressed: () {
          Navigator.of(context).pop(true); // dismiss dialog
          cart.removeItem(id);
        },
      );

  Widget _getAlertDialog(BuildContext ctx, TextButton button) {
    return AlertDialog(
      title: const Text("Remove item from the cart"),
      content:
          const Text("Do you really want to remove this item from the cart?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop(false);
          },
          child: const Text("Cancel"),
        ),
        button
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Cart>(context, listen: false);
    final product = Provider.of<CartProduct>(context);

    return Dismissible(
      key: ValueKey(product.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => _getAlertDialog(
                context, _removeItem(context, data, product.id)));
      },
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.only(right: 20.0),
        margin: const EdgeInsets.all(5),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CartItem.cornerDoundness),
        ),
        child: GestureDetector(
          onTap: () {
            //Just forward the product id so that related data can be fetched
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(CartItem.cornerDoundness)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The following widget helps to make its child clippable
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(CartItem.cornerDoundness),
                    bottomLeft: Radius.circular(CartItem.cornerDoundness),
                  ),
                  child: Image.network(
                    Provider.of<ProductsProvider>(context)
                        .getImageUrl(product.id),
                    height: CartItem.imageHeight,
                    width: CartItem.imageWidth,
                    fit: BoxFit.cover,
                  ),
                ),
                const Spacer(),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(CartItem.cornerDoundness),
                    bottomRight: Radius.circular(CartItem.cornerDoundness),
                  ),
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width -
                          CartItem.imageWidth -
                          18.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Spacer(),
                                  Text(
                                    'AU \$${product.totalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Qty",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: TextField(
                                      controller: getController(
                                          product.quantity.toString()),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 0.4),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: (() {
                                      final qty = int.parse(_controller.text);
                                      data.updateCartItem(product.id, qty);
                                    }),
                                    child: const Text("Update quantity"),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                    onPressed: () => showDialog(
                                        context: context,
                                        builder: (ctx) => _getAlertDialog(
                                            context,
                                            _removeItem(
                                                context, data, product.id))),
                                    child: const Text("Remove"),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
