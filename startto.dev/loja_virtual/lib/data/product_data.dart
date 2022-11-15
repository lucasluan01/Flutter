import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String? id;
  String? category;
  String? name;
  String? description;
  num? price;
  List? images;
  List? sizes;

  ProductData.fromDocument(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    id = snapshot.id;
    name = snapshot.get("name");
    description = snapshot.get("description");
    price = snapshot.get("price");
    images = snapshot.get("images");
    sizes = snapshot.get("sizes");
  }

  Map<String, dynamic> toResumeMap() {
    return {
      "name": name,
      "description": description,
      "price": price,
    };
  }
}
