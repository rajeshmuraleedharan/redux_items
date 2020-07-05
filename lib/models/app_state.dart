import 'package:flutter/foundation.dart';
import 'package:redux_items/models/item.dart';

class AppState {
  final List<Item> items;

  AppState({@required this.items});

  AppState.initialState() : items = List.unmodifiable(<Item>[]);
}
