import 'package:flutter/material.dart';
import 'package:shopping/providers/cart.dart';
import 'package:shopping/providers/product_provider.dart';
import 'package:shopping/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  static const double cornerDoundness = 3;
  static const double imageHeight = 140;
  static const double imageWidth = 140;

  const ProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    // Get product from the Provider
    return Consumer<Product>(
      builder: ((context, product, child) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ProductItem.cornerDoundness),
            ),
            child: GestureDetector(
              onTap: () {
                // Just forward the product id so that related data can be fetched
                Navigator.of(context).pushNamed(
                  ProductDetailScreen.routeName,
                  arguments: product.id,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ProductItem.cornerDoundness)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // The following widget helps to make its child clippable
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(ProductItem.cornerDoundness),
                        bottomLeft:
                            Radius.circular(ProductItem.cornerDoundness),
                      ),
                      child: Image.network(
                        product.imageUrl,
                        height: ProductItem.imageHeight,
                        width: ProductItem.imageWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Spacer(),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(ProductItem.cornerDoundness),
                        bottomRight:
                            Radius.circular(ProductItem.cornerDoundness),
                      ),
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width -
                              ProductItem.imageWidth -
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
                                  Text(
                                    'AU \$${product.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    // iconSize: 18,
                                    // padding and constraints are needed to remove the auto added padding inside the IconButton
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: (() {
                                      cart.addItem(
                                        product.id,
                                        product.price,
                                        product.title,
                                      );
                                    }),
                                    icon: const Icon(Icons.shopping_cart),
                                  ),
                                  IconButton(
                                    // iconSize: 18,
                                    // padding and constraints are needed to remove the auto added padding inside the IconButton
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: (() {
                                      product.toggleFavorite();
                                    }),
                                    icon: Icon(
                                      product.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
