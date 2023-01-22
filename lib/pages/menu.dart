import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ders5/pages/sepet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../list.dart';
import '../servisler/urun_service.dart';

class UrunListPage extends StatefulWidget {
  UrunListPage({required this.masa});
  final String masa;
  @override
  State<UrunListPage> createState() => _UrunListPageState();
}

class _UrunListPageState extends State<UrunListPage> {
  final _firestore = FirebaseFirestore.instance;
  UrunService _urunService = UrunService();

  @override
  Widget build(BuildContext context) {
    final CollectionReference sepetRef = _firestore.collection('sepet');

    return Scaffold(
      appBar: AppBar(
        title: Text('Menü'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return sepet(mas: widget.masa);
                }));
              },
              icon: const Icon(Icons.shopping_cart)),
          SizedBox(width: 20),
        ],
        backgroundColor: Color(0xff603601),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color(0xfff0c2a3),
              Color(0xfff0c2a3),
              //Color(0xffffefd5),
              //Color(0xffffebcd),
            ])),
        child: StreamBuilder<QuerySnapshot>(
          stream: _urunService.getUrun(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? CircularProgressIndicator()
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 50,
                      childAspectRatio: MediaQuery.of(context).size.height /
                          (MediaQuery.of(context).size.height),
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      DocumentSnapshot myurun = snapshot.data!.docs[index];

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: liste[index].image,
                                  ),
                                ),
                                Text(
                                  "${myurun['urun_ad']}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${myurun['fiyat']} ₺",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            onTap: () async {
                              Map<String, dynamic> urun = {
                                'urun_ad': myurun['urun_ad'],
                                'fiyat': myurun['fiyat'],
                                'adet': 1
                              };
                              var result = await FirebaseFirestore.instance
                                  .collection("sepet")
                                  .doc(widget.masa)
                                  .get();
                              if (result.data()!.isNotEmpty) {
                                List urunList = result.data()!["urunler"] ?? [];
                                bool varMi = false;
                                for (var element in urunList) {
                                  if (element["urun_ad"] == myurun['urun_ad']) {
                                    varMi = true;

                                    element = urun;
                                  }
                                }
                                if (!varMi) {
                                  urunList.add(urun);
                                }

                                print(widget.masa);
                                await FirebaseFirestore.instance
                                    .collection("sepet")
                                    .doc(widget.masa)
                                    .update({'urunler': urunList});
                              }
                            },
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
