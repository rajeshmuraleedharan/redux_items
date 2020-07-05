import 'package:flutter/material.dart';
import 'package:redux_items/models/item_view_model.dart';

class RemoveItemsButtonWidget extends StatelessWidget{
  final ItemViewModel model;

  RemoveItemsButtonWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Delete all Items"),
      onPressed: (){
        model.onRemoveItems();
      },
    );
  }
}