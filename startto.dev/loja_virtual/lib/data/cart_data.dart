import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/data/product_data.dart';

class CartData {
  String? cartId;
  String? category;
  String? productId;
  int? quantity;
  String? size;

  ProductData? productData;

  CartData();

  CartData.fromDocument(DocumentSnapshot snapshot) {
    cartId = snapshot.id;
    category = snapshot.get("category");
    productId = snapshot.get("productId");
    quantity = snapshot.get("quantity");
    size = snapshot.get("size");
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "productId": productId,
      "quantity": quantity,
      "size": size,
      "product": productData?.toResumeMap(),
    };
  }
}
