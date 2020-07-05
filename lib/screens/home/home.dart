import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

import 'package:redux_items/models/app_state.dart';
import 'package:redux_items/models/item_view_model.dart';
import 'package:redux_items/screens/item/manage_items.dart';

class MyHomePage extends StatelessWidget {
  final DevToolsStore<AppState> store;

  MyHomePage(this.store);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redux Items"),
      ),
      body: StoreConnector<AppState, ItemViewModel>(
        converter: (Store<AppState> store) => ItemViewModel.create(store),
        builder: (BuildContext context, ItemViewModel viewModel) =>
            ManageItemsWidget(viewModel),
      ),
      drawer: Container(
        child: ReduxDevTools(store),
      ),
    );
  }
}
