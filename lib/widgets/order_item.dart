import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';

class _OrderColumn extends StatelessWidget {
  final String title;
  final String subtitle;
  Color? color = Colors.black54;
  // final String? author;
  // final String? publishDate;
  // final String? readDuration;

  _OrderColumn({
    required this.title,
    required this.subtitle,
    this.color,
    // this.author,
    // this.publishDate,
    // this.readDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final Order order;
  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Order Details",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Text('Online #${order.id}')
        ],
      ),
      subtitle: Text(
        DateFormat('dd MMM yyyy').format(order.dateTime),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // const Divider(
              //   // height: 20,
              //   thickness: 2,
              //   endIndent: 0,
              //   color: Colors.black,
              // ),
              Row(
                children: const [
                  Expanded(
                    child: Text(
                      "Item",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Quantity",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60.0 * order.products.length,
                child: ListView.builder(
                  itemCount: order.products.length,
                  itemBuilder: ((context, index) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 5,
                              child: Text(
                                order.products[index].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(height: 2),
                              )),
                          const Spacer(),
                          Expanded(
                            child: Text(
                              order.products[index].quantity.toString(),
                              textAlign: TextAlign.end,
                              style: const TextStyle(height: 2),
                            ),
                          )
                        ],
                      )),
                ),
              ),

              const Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                      flex: 3,
                      child: Text(
                        "Total amount payable",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      )),
                  const Spacer(),
                  Expanded(
                    child: Text(
                      '\$${order.amount.toStringAsFixed(2)}',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
