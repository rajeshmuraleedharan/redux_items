import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_items/redux/actions.dart';
import 'package:redux_items/redux/middleware.dart';
import 'package:redux_items/screens/home/home.dart';

import 'models/app_state.dart';
import 'redux/reducers.dart';
import 'redux/middleware.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store<AppState> store =
        Store<AppState>(appStateReducer, 
        initialState: AppState.initialState(),
        middleware: [appStateMiddleware]);

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData.dark(),
        home: StoreBuilder<AppState>(
          onInit: (store) => store.dispatch(GetItemsAction()),
          builder: (BuildContext context, Store<AppState> store) =>
            MyHomePage(store),
        ),
      ),
    );
  }
}