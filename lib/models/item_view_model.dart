import 'package:redux/redux.dart';
import 'package:redux_items/models/item.dart';
import 'package:redux_items/redux/actions.dart';

import 'app_state.dart';
import 'item.dart';

class ItemViewModel {
  final List<Item> items;
  final Function(String) onAddItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveItems;

  ItemViewModel(
      {this.items, this.onAddItem, this.onRemoveItem, this.onRemoveItems});

  factory ItemViewModel.create(Store<AppState> store) {
    _onAddItem(String body) => store.dispatch(AddItemAction(body));

    _onRemoveItem(Item item) => store.dispatch(RemoveItemAction(item));

    _onRemoveItems() => store.dispatch(RemoveItemsAction());

    return ItemViewModel(
        items: store.state.items,
        onAddItem: _onAddItem,
        onRemoveItem: _onRemoveItem,
        onRemoveItems: _onRemoveItems);
  }
}