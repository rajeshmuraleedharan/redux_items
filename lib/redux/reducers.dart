import 'package:redux_items/models/item.dart';
import 'package:redux_items/models/app_state.dart';
import 'package:redux_items/redux/actions.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(items: itemReducer(state.items, action));
}

List<Item> itemReducer(List<Item> state, action) {
  if (action is AddItemAction) {
    return []
      ..addAll(state)
      ..add(Item(id: action.id, body: action.item));
  }

  if (action is RemoveItemAction) {
    return List.unmodifiable(List.from(state)..remove(action.item));
  }

  if (action is RemoveItemsAction) {
    return List.unmodifiable([]);
  }

  if (action is LoadedItemsAction) {
    return action.items;
  }

  if (action is ItemCompletedAction) {
    return state.map((Item item) => item.id == action.item.id
          ? item.copyWith(completed: !item.completed)
          : item).toList();
  }

  return state;
}
