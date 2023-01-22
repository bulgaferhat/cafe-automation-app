import 'package:cloud_firestore/cloud_firestore.dart';

class SiparisService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<DocumentSnapshot<Map<String, dynamic>>> getSiparis(String masa) {
    var ref = _firestore.collection("sepet").doc(masa).snapshots();
    return ref;
  }
}
