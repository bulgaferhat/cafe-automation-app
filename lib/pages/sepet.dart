import 'package:ders5/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../servisler/siparis_service.dart';

class sepet extends StatefulWidget {
  sepet({required this.mas});
  final String mas;

  @override
  State<sepet> createState() => _sepetState();
}

class _sepetState extends State<sepet> {
  final _firestore = FirebaseFirestore.instance;

  SiparisService _siparisService = SiparisService();

  List urunler = [];

  a_cek() async {
    var response = await FirebaseFirestore.instance
        .collection("sepet")
        .doc(widget.mas)
        .get();

    urunler = (response.data() ?? {})["urunler"] ?? [];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    a_cek();
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference urunlerRef = _firestore.collection('urunler');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Siparişleriniz',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
        ),
        backgroundColor: Color(0xff603601),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xfff0c2a3),
              Color(0xfff0c2a3),
            ])),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: urunler.length,
                  itemBuilder: (context, index) {
                    var mysiparis = urunler[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${mysiparis["urun_ad"]}  =>",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      mysiparis["adet"]++;
                                      setState(() {});
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        " + ",
                                        style: const TextStyle(
                                            fontSize: 30, color: Colors.white),
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff90502e),
                                        shadowColor: Colors.black,
                                        elevation: 20,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                  ),
                                ),
                              ),
                              Text(
                                "Adet: ${mysiparis["adet"]}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      mysiparis["adet"]--;
                                      if (mysiparis["adet"] <= 0) {
                                        urunler.removeAt(index);
                                      }
                                      setState(() {});
                                    },
                                    child: Text(
                                      " - ",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontSize: 35, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff90502e),
                                        shadowColor: Colors.black,
                                        elevation: 20,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("sepet")
                      .doc(widget.mas)
                      .update({"urunler": urunler});
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyHomePage();
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Siparişi Onayla",
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff90502e),
                    shadowColor: Colors.black,
                    elevation: 20,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
          ],
        ),
      ),
    );
  }
}
