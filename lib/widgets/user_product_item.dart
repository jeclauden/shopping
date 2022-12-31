import 'package:flutter/material.dart';

enum MenuItem {
  edit,
  delete,
}

class UserProductItem extends StatelessWidget {
  const UserProductItem({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: PopupMenuButton<MenuItem>(
          onSelected: (selectionMenu) {
            //..
          },
          itemBuilder: ((_) => <PopupMenuEntry<MenuItem>>[
                const PopupMenuItem<MenuItem>(
                  value: MenuItem.edit,
                  child: Text("Edit Product"),
                ),
                const PopupMenuItem<MenuItem>(
                  value: MenuItem.delete,
                  child: Text("Delete Product"),
                ),
              ]),
          icon: const Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
