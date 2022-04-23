import 'package:final_project/post_recipes.dart';
import 'package:final_project/signup.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatelessWidget {
  login({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  var _email = TextEditingController();
  var _password = TextEditingController();
  var _display = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Center(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // TextFormField(
                  //   controller: _display,
                  //   validator: (String? value) {},
                  //   decoration: const InputDecoration(
                  //     hintText: "Enter User Name",
                  //   ),
                  // ),
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
                      } else if (value.length < 2) {
                        return "Wrong password";
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter Password",
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login(context);
                        }
                        // _role(context);
                      },
                      child: const Text("Login")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: const Text("Register")),
                  // TextButton(
                  //     onPressed: () { }, child: const Text("Login with Google")),
                ],
              )),
        ));
  }

  void _login(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
      ScaffoldMessenger.of(context).clearSnackBars();
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Email/Password combination is incorrect")));
      }
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => postRecipes(recipes: "recipes")));
  }

  // void _profile(context) async{
  //   User? user = FirebaseAuth.instance.currentUser;
  //   final DocumentSnapshot snap = await _db
  //       .collection('users').doc(user!.uid).get();
  //   var role = snap.get("role");
  //   if(role == 'USER'){
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => SignUpPage()));
  //   } else if (role == 'ADMIN'){
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => SignUpPage()));
  //   }
  // }
}
