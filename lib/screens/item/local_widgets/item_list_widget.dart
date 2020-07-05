import 'package:flutter/material.dart';
import 'package:redux_items/models/item.dart';
import 'package:redux_items/models/item_view_model.dart';

class ItemListWidget extends StatefulWidget {
  final ItemViewModel model;

  ItemListWidget(this.model);

  @override
  State<StatefulWidget> createState() => _ItemListState();
}

class _ItemListState extends State<ItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.model.items.map((Item item) => ListTile(
        title: Text(item.body),
        leading: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => widget.model.onRemoveItem(item),
        ),
      )).toList(),
    );
  }
}