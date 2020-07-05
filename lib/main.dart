import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_items/models/item.dart';

import 'models/app_state.dart';
import 'redux/actions.dart';
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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redux Items"),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) => Column(
          children: <Widget>[
            AddItemWidget(viewModel),
            Expanded(
              child: ItemListWidget(viewModel),
            ),
            RemoveItemsButtonWidget(viewModel),
          ],
        ),
      ),
    );
  }
}

class AddItemWidget extends StatefulWidget {
  final _ViewModel model;

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

class ItemListWidget extends StatefulWidget {
  final _ViewModel model;

  ItemListWidget(this.model);

  @override
  State<StatefulWidget> createState() => _ItemListState();
}

class _ItemListState extends State<ItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.model.items.map((Item item) => ListTile(
        title: Text(item.body),
        leading: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => widget.model.onRemoveItem(item),
        ),
      )).toList(),
    );
  }
}

class RemoveItemsButtonWidget extends StatelessWidget{
  final _ViewModel model;

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

class _ViewModel {
  final List<Item> items;
  final Function(String) onAddItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveItems;

  _ViewModel(
      {this.items, this.onAddItem, this.onRemoveItem, this.onRemoveItems});

  factory _ViewModel.create(Store<AppState> store) {
    _onAddItem(String body) => store.dispatch(AddItemAction(body));

    _onRemoveItem(Item item) => store.dispatch(RemoveItemAction(item));

    _onRemoveItems() => store.dispatch(RemoveItemsAction());

    return _ViewModel(
        items: store.state.items,
        onAddItem: _onAddItem,
        onRemoveItem: _onRemoveItem,
        onRemoveItems: _onRemoveItems);
  }
}
