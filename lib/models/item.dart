import 'package:flutter/foundation.dart';

class Item {
  final int id;
  final String body;

  Item({@required this.id, @required this.body});

  Item copyWith({int id, String body}) {
    return Item(id: id ?? this.id, body: body ?? this.body);
  }

  Item.fromJson(Map json)
      : id = json["id"],
        body = json["body"];

  Map toJson() => {
    "id": id,
    "body": body
  };
}
