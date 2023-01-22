import 'package:cloud_firestore/cloud_firestore.dart';

class Urun {
  late String id;
  late String urun_ad;
  late int fiyat;
  Urun({
    required this.id,
    required this.urun_ad,
    required this.fiyat,
  });

  factory Urun.fromSnapshot(DocumentSnapshot snapshot) {
    return Urun(
      id: snapshot.id,
      urun_ad: snapshot["urun_ad"],
      fiyat: snapshot["fiyat"],
    );
  }
}
