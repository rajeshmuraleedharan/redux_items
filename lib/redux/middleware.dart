
import 'package:redux/redux.dart';
import 'package:redux_items/utils/manage_prefs.dart';

import 'package:redux_items/models/app_state.dart';
import 'package:redux_items/redux/actions.dart';

List<Middleware<AppState>> appStateMiddleware(
  [AppState state = const AppState(items: [])]) {
  final loadFromPrefs = _loadFromPrefs(state);
  final saveToPrefs = _saveToPrefs(state);

  return [
    TypedMiddleware<AppState, AddItemAction>(saveToPrefs),
    TypedMiddleware<AppState, RemoveItemAction>(saveToPrefs),
    TypedMiddleware<AppState, RemoveItemsAction>(saveToPrefs),
    TypedMiddleware<AppState, ItemCompletedAction>(saveToPrefs),
    TypedMiddleware<AppState, GetItemsAction>(loadFromPrefs),
  ];
}

Middleware<AppState> _loadFromPrefs(AppState state) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    ManagePrefsUtil.loadFromPrefs()
    .then((AppState state) => 
      store.dispatch(LoadedItemsAction(state.items))
    );    
  };
}

Middleware<AppState> _saveToPrefs(AppState state){
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    ManagePrefsUtil.saveToPrefs(store.state);
  };
}