import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ders5/pages/menu.dart';
import 'package:ders5/servisler/masa_service.dart';
import 'package:flutter/material.dart';
import '../list.dart';

class musteri extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  MasaService _masaService = MasaService();

  @override
  Widget build(BuildContext context) {
    final CollectionReference sepetRef = _firestore.collection('sepet');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Masalar ',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
        child: StreamBuilder<QuerySnapshot>(
          stream: _masaService.getMasalar(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? CircularProgressIndicator()
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      DocumentSnapshot mymasa = snapshot.data!.docs[index];

                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: InkWell(
                          onTap: () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return UrunListPage(masa: mymasa['masa_ad']);
                            }));
                            Map<String, dynamic> masa = {
                              'masa_ad': mymasa['masa_ad'],
                              'durum': mymasa['durum']
                            };
                            await sepetRef.doc(mymasa['masa_ad']).set(masa);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.width / 4,
                                padding: const EdgeInsets.all(8.0),
                                child: barcodes[index].image,
                              ),
                              Text(
                                "${mymasa['masa_ad']}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      );
                    }));
          },
        ),
      ),
    );
  }
}
