import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../widgets/my_elevated_button.dart';

enum Actions1 { register, update }

class RegisterPage extends StatelessWidget {
  const RegisterPage(
      {super.key,
      required this.usernameCtrl,
      required this.passwordCtrl,
      required this.emailCtrl,
      this.username = "",
      this.action = Actions1.register});

  final TextEditingController usernameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final Actions1 action;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
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
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextFormField(
              decoration: InputDecoration(
                  label: Text("Username"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: usernameCtrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextFormField(
              decoration: InputDecoration(
                  label: Text("E-Mail"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: emailCtrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: TextFormField(
              decoration: InputDecoration(
                  label: Text("Password"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              controller: passwordCtrl,
              obscureText: true,
            ),
          ),
          MyElevatedButton(
              child: Text("Register"),
              color: Color(0xff90502e),
              onPressed: () async {
                var user = UserModel(
                    username: usernameCtrl.text,
                    email: emailCtrl.text,
                    password: passwordCtrl.text);
                if (action == Actions1.register) {
                  await FirebaseFirestore.instance
                      .collection("users")
                      .add(user.toJson());
                } else {
                  var response = await FirebaseFirestore.instance
                      .collection("users")
                      .where("username", isEqualTo: username)
                      .limit(1)
                      .get();
                  if (response.docs.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(response.docs.first.id)
                        .set(user.toJson());
                  }
                }
                Navigator.pop(context);
              })
        ]),
      ),
    );
  }
}
