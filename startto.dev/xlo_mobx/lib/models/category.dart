import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class Category {
  final String? id, description;

  Category({
    required this.id,
    this.description,
  });

  Category.fromParse(ParseObject parseObject)
      : id = parseObject.objectId,
        description = parseObject.get(keyCategoryDescription);

  @override
  toString() {
    return "Category {id: $id, description: $description}";
  }
}
