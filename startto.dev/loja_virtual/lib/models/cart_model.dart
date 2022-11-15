import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/data/cart_data.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  bool isLoading = false;
  List<CartData> products = [];
  String? couponCode;
  int discountPercentage = 0;

  CartModel(this.user) {
    if (user.isLoggedIn()) {
      loadCartItems();
    }
  }

  static CartModel of(BuildContext context) {
    return ScopedModel.of(context);
  }

  void addCartItem(CartData cartData) {
    products.add(cartData);

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.user!.uid)
        .collection("cart")
        .add(cartData.toMap())
        .then((doc) => cartData.cartId = doc.id);
    notifyListeners();
  }

  void removeCartItem(CartData cartData) {
    products.remove(cartData);
    FirebaseFirestore.instance.collection("users").doc(user.user!.uid).collection("cart").doc(cartData.cartId).delete();
    notifyListeners();
  }

  void decProduct(CartData cart) {
    cart.quantity = cart.quantity! - 1;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.user!.uid)
        .collection("cart")
        .doc(cart.cartId)
        .update(cart.toMap());

    notifyListeners();
  }

  void incProduct(CartData cart) {
    cart.quantity = cart.quantity! + 1;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.user!.uid)
        .collection("cart")
        .doc(cart.cartId)
        .update(cart.toMap());

    notifyListeners();
  }

  void loadCartItems() async {
    QuerySnapshot<Map<String, dynamic>> query =
        await FirebaseFirestore.instance.collection("users").doc(user.user!.uid).collection("cart").get();

    products = query.docs.map((doc) => CartData.fromDocument(doc)).toList();

    notifyListeners();
  }

  void setCoupon(String? couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void updatePrices() {
    notifyListeners();
  }

  double getproductsPrice() {
    double price = 0.0;

    for (CartData prod in products) {
      // inspect(prod.productData);
      if (prod.productData != null) {
        price += prod.quantity! * prod.productData!.price!;
      }
    }

    return price;
  }

  double getShipPrice() {
    return 9.99;
  }

  double getDiscount() {
    return getproductsPrice() * discountPercentage / 100;
  }

  Future<String> finishOrder() async {
    isLoading = true;
    notifyListeners();

    double price = getproductsPrice();
    double discount = -getDiscount();
    double ship = getShipPrice();
    double total = ship + discount + price;

    DocumentReference refOrder = await FirebaseFirestore.instance.collection("orders").add({
      "userId": user.user!.uid,
      "products": products.map((cart) => cart.toMap()).toList(),
      "shipPrice": ship,
      "productsPrice": price,
      "discount": discount,
      "total": total,
      "status": 1,
    });

    FirebaseFirestore.instance.collection("users").doc(user.user!.uid).collection("orders").doc(refOrder.id).set({
      "orderId": refOrder.id,
    });

    QuerySnapshot query =
        await FirebaseFirestore.instance.collection("users").doc(user.user!.uid).collection("cart").get();

    for (var doc in query.docs) {
      doc.reference.delete();
    }

    products.clear();
    discountPercentage = 0;
    notifyListeners();
    isLoading = false;

    return refOrder.id;
  }
}
