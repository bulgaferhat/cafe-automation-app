import 'package:cloud_firestore/cloud_firestore.dart';

class masalar {
  late String masa_ad;
  masalar({
    required this.masa_ad,
  });

  factory masalar.fromSnapshot(DocumentSnapshot snapshot) {
    return masalar(
      masa_ad: snapshot["masa_ad"],
    );
  }
}
