import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_items/screens/home/home.dart';

import 'models/app_state.dart';
import 'redux/reducers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store<AppState> store =
        Store<AppState>(appStateReducer, initialState: AppState.initialState());

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData.dark(),
        home: MyHomePage(),
      ),
    );
  }
}