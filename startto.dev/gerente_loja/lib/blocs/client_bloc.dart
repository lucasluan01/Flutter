import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ClientBloc extends BlocBase {
  final _clientController = BehaviorSubject<List>();
  final Map<String, Map<String, dynamic>> _clients = {};
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List> get outClients => _clientController.stream;

  ClientBloc() {
    _addClientsListener();
  }

  void _addClientsListener() {
    _firestore.collection("users").snapshots().listen((snapshot) {
      for (var element in snapshot.docChanges) {
        String uid = element.doc.id;

        switch (element.type) {
          case DocumentChangeType.added:
            _clients[uid] = element.doc.data()!;
            _subscribeToOrders(uid);
            break;
          case DocumentChangeType.modified:
            _clients[uid]!.addAll(element.doc.data()!);
            break;
          case DocumentChangeType.removed:
            _clients[uid]!.remove(uid);
            _unsubscribeToOrders(uid);
            break;
        }
      }
    });
  }

  void _subscribeToOrders(String uid) {
    _clients[uid]!["subscription"] =
        _firestore.collection("users").doc(uid).collection("orders").snapshots().listen((orders) async {
      int numOrders = orders.docs.length;
      num money = 0.0;

      for (var doc in orders.docs) {
        DocumentSnapshot<Map<String, dynamic>> order = await _firestore.collection("orders").doc(doc.id).get();

        if (order.data() == null) {
          continue;
        }
        money += order.data()!["total"];
      }

      _clients[uid]!.addAll({
        "money": money,
        "orders": numOrders,
      });
      _clientController.add(_clients.values.toList());
    });
  }

  void _unsubscribeToOrders(String uid) {
    _clients[uid]!["subscription"].cancel();
  }

  @override
  void dispose() {
    super.dispose();
    _clientController.close();
  }
}
