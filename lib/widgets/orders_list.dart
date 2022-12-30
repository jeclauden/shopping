import 'package:flutter/material.dart';
import '/providers/orders.dart';
import '/widgets/order_item.dart';

import 'package:provider/provider.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using Provider
    final orders = Provider.of<Orders>(context).orders;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: ((context, index) => OrderItem(
              order: orders[index],
            )),
      ),
    );
  }
}
