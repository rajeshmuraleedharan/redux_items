import 'package:flutter/material.dart';
import 'package:redux_items/models/item_view_model.dart';

class AddItemWidget extends StatefulWidget {
  final ItemViewModel model;

  AddItemWidget(this.model);

  @override
  State<StatefulWidget> createState() => _AddItemState();
}

class _AddItemState extends State<AddItemWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: "add an item"),
      onSubmitted: (String s) {
        widget.model.onAddItem(s);
        controller.text = "";
      },
    );
  }
}
