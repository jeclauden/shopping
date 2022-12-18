import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool? isFavorite;
  static const double cornerDoundness = 3;
  static const double imageHeight = 130;
  static const double imageWidth = 130;

  ProductItem(
      {super.key,
      required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ProductItem.cornerDoundness),
      ),
      // elevation: 10,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ProductItem.cornerDoundness)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // The following widget helps to make its child clippable
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(ProductItem.cornerDoundness),
                bottomLeft: Radius.circular(ProductItem.cornerDoundness),
              ),
              child: Image.network(
                imageUrl,
                height: ProductItem.imageHeight,
                width: ProductItem.imageWidth,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(ProductItem.cornerDoundness),
                bottomRight: Radius.circular(ProductItem.cornerDoundness),
              ),
              child: Container(
                  padding: const EdgeInsets.all(8),
                  // decoration: BoxDecoration(color: Colors.grey.shade300),
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
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'AU \$${price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            iconSize: 18,
                            // padding and constraints are needed to remove the auto added padding inside the IconButton
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: (() {}),
                            icon: const Icon(Icons.shopping_cart_outlined),
                          ),
                          IconButton(
                            iconSize: 18,
                            // padding and constraints are needed to remove the auto added padding inside the IconButton
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: (() {}),
                            icon: const Icon(Icons.favorite_border_outlined),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
