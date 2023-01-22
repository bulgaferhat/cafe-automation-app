import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../servisler/siparis_service.dart';
import '../servisler/siparismasalari_service.dart';

class garson extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  final masasiparisService _masasiparisService = masasiparisService();
  final SiparisService _siparisService = SiparisService();

  @override
  Widget build(BuildContext context) {
    final CollectionReference sepetRef = _firestore.collection('sepet');
    final DocumentReference masaRef = sepetRef.doc('masa');
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff603601),
          centerTitle: true,
          title: Text(
            'Garson',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xfff0c2a3),
              Color(0xfff0c2a3),
            ])),
        child: Center(
          child: StreamBuilder(
              stream: _masasiparisService.getMasaSiparis(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot mysiparis =
                              snapshot.data!.docs[index];

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "${mysiparis['masa_ad']} : ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                    height: 100,
                                  ),
                                  SizedBox(
                                    height: 60,
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (mysiparis['durum'] == "hazır") {
                                          var response = await FirebaseFirestore
                                              .instance
                                              .collection("sepet")
                                              .where("masa_ad",
                                                  isEqualTo:
                                                      mysiparis['masa_ad'])
                                              .get();

                                          if (response.docs.isNotEmpty) {
                                            showDialog(
                                                context: context,
                                                builder: ((context) => Dialog(
                                                      child: ListView.builder(
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                    "${response.docs.first.data()["urunler"][index]["urun_ad"]},${response.docs.first.data()["urunler"][index]["adet"]}"),
                                                              ),
                                                          itemCount: response
                                                              .docs.first
                                                              .data()["urunler"]
                                                              .length),
                                                    )));
                                          }
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: ((context) => Dialog(
                                                    child: ListView.builder(
                                                      itemBuilder:
                                                          (context, index) =>
                                                              ListTile(
                                                        title: Text(" "),
                                                      ),
                                                    ),
                                                  )));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xff90502e),
                                          shadowColor: Colors.black,
                                          elevation: 20,
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              side: BorderSide(
                                                  color: Colors.black))),
                                      child: Container(
                                        width: 100,
                                        height: 60,
                                        alignment: Alignment.center,
                                        child: const Text(
                                          'Siparişleri Göster',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  FirebaseFirestore.instance
                                      .collection("sepet")
                                      .doc(mysiparis['masa_ad'])
                                      .update({"durum": "teslim edildi"});
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff90502e),
                                    shadowColor: Colors.black,
                                    elevation: 20,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(color: Colors.black))),
                                child: Container(
                                  width: 100,
                                  height: 60,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Siparis teslim edildi',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          );
                        });
              }),
        ),
      ),
    );
  }
}
