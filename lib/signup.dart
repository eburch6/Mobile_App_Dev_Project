import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  var _email = TextEditingController();
  var _password = TextEditingController();
  var _username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
          backgroundColor: const Color(0xff9e9e9e),
        ),
        body: Center(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _username,
                    validator: (String? value) {},
                    decoration: const InputDecoration(
                      hintText: "Enter User Name",
                    ),
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      hintText: "Enter Email",
                    ),
                  ),

                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    validator: (String? value) {
                      if (value == null) {
                        return "Password cannot be empty";
                      } else if (value.length < 8) {
                        return "Your password must be 8 characters or longer";
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter Password",
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (String? value) {
                      if (value != _password.text) {
                        return "Password must match";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter Password Again",
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _register(context);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Your account has been registered successfully!")));
                      },
                      child: const Text("Register")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => login()));
                      },
                      child: const Text("Login")),
                ],
              )),
        ));
  }

  void _register(BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: _email.text, password: _password.text);
      ScaffoldMessenger.of(context).clearSnackBars();
    } on FirebaseException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
            Text("A user with that email already exists in our database")));
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("This password is to insecure to be used")));
      }
      return;
    }
    try {
      await _db.collection("users").doc(_auth.currentUser!.uid).set({
        "username": _username.text,
        "email": _email.text,
        "registration_datetime":Timestamp.now()
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "Unknown Error")));
    }
  }
}