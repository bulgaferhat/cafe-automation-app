import 'package:cloud_firestore/cloud_firestore.dart';

class masasiparisService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMasaSiparis() {
    var ref = _firestore.collection("sepet").snapshots();

    return ref;
  }
}
