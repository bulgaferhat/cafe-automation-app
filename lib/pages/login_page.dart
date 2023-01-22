import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ders5/pages/HomePage.dart';
import 'package:ders5/pages/personel.dart';
import '../widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'register_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        centerTitle: true,
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 350.0, vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text("Username"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: usernameCtrl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lütfen geçerli bir kullanıcı adı giriniz!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 350.0, vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      label: Text("Password"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: passwordCtrl,
                  obscureText: true,
                ),
              ),
              MyElevatedButton(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Color(0xff90502e),
                  onPressed: () async {
                    var response = await FirebaseFirestore.instance
                        .collection("users")
                        .where("username", isEqualTo: usernameCtrl.text)
                        .where("password", isEqualTo: passwordCtrl.text)
                        .limit(1)
                        .get();
                    if (response.docs.isNotEmpty) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => personel()));
                    } else
                      (showDialog(
                        context: context,
                        builder: ((context) => AlertDialog(
                              title: Text(
                                "Yanlis kullanici adi veya sifre",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ));
                  }),
              SizedBox(
                height: 10,
              ),
              MyElevatedButton(
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Color(0xff90502e),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage(
                                  usernameCtrl: usernameCtrl,
                                  passwordCtrl: passwordCtrl,
                                  emailCtrl: TextEditingController(),
                                  action: Actions1.register,
                                )));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
