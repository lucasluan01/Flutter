import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class OrdersBloc extends BlocBase {
  final _ordersController = BehaviorSubject<List>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<DocumentSnapshot> _orders = [];

  Stream<List> get outOrders => _ordersController.stream;

  OrdersBloc() {
    _addOrdersListener();
  }

  void _addOrdersListener() {
    _firestore.collection("orders").snapshots().listen((snapshot) {
      for (var doc in snapshot.docChanges) {
        String uid = doc.doc.id;

        switch (doc.type) {
          case DocumentChangeType.added:
            _orders.add(doc.doc);
            break;
          case DocumentChangeType.modified:
            _orders.removeWhere((order) => order.id == uid);
            _orders.add(doc.doc);
            break;
          case DocumentChangeType.removed:
            _orders.removeWhere((order) => order.id == uid);
            break;
        }
      }
      _ordersController.add(_orders);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _ordersController.close();
  }
}
