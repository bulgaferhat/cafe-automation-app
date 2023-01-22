import 'package:cloud_firestore/cloud_firestore.dart';

class MasaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getMasalar() {
    var ref = _firestore.collection("masalar").snapshots();

    return ref;
  }
}