
import 'package:redux/redux.dart';
import 'package:redux_items/utils/manage_prefs.dart';

import 'package:redux_items/models/app_state.dart';
import 'package:redux_items/redux/actions.dart';

void appStateMiddleware(Store<AppState> store, action, NextDispatcher next) {
  next(action);

  if (action is AddItemAction ||
      action is RemoveItemsAction ||
      action is RemoveItemAction ||
      action is ItemCompletedAction) {
        ManagePrefsUtil.saveToPrefs(store.state);
      }

  if (action is GetItemsAction){
    ManagePrefsUtil.loadFromPrefs()
    .then((AppState state) => 
      store.dispatch(LoadedItemsAction(state.items))
    );    
  }
}
