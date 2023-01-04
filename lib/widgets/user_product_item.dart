import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/providers/products_provider.dart';
import 'package:shopping/screens/edit_product_screen.dart';

class CustomBottomSheet extends StatelessWidget {
  final double _roundness = 10.0;
  final String productId;
  const CustomBottomSheet({required this.productId, super.key});

  ClipRRect getButtonItem(
    VoidCallback function,
    String text,
    bool rounded,
    bool bolded,
    bool destructive,
  ) {
    return ClipRRect(
      borderRadius:
          BorderRadius.all(Radius.circular(rounded ? _roundness : 0.0)),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 62,
        child: TextButton(
          onPressed: function,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: bolded ? FontWeight.w500 : FontWeight.normal,
                color: destructive ? Colors.red : Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(_roundness)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(_roundness)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    getButtonItem(() {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(
                        EditProductScreen.routeName,
                        arguments: productId,
                      );
                    }, "Edit Product", false, false, false),
                    const Divider(),
                    getButtonItem(() {
                      Provider.of<ProductsProvider>(context, listen: false)
                          .removeProduct(productId);
                      Navigator.pop(context);
                    }, "Delete Product", false, false, true),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            getButtonItem(() {
              Navigator.pop(context);
            }, "Cancel", true, true, false),
          ],
        ),
      ),
    );
  }
}

class UserProductItem extends StatelessWidget {
  const UserProductItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.id,
  });

  final String title;
  final String imageUrl;
  final String id;

  static const double margin = 30.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: IconButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (context) => CustomBottomSheet(
                productId: id,
              ),
              constraints: BoxConstraints(
                maxWidth:
                    MediaQuery.of(context).size.width - UserProductItem.margin,
              ),
              backgroundColor: Colors.red.withOpacity(0.0),
            );
          },
          icon: const Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
