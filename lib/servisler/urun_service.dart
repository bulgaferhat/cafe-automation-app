import 'package:cloud_firestore/cloud_firestore.dart';

class UrunService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUrun() {
    var ref = _firestore.collection("urun").snapshots();

    return ref;
  }
}
