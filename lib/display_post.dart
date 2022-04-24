//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:final_project/post.dart';
// import 'package:flutter/material.dart';
//
//
// class Posts extends StatefulWidget {
//   const Posts({Key? key}) : super(key: key);
//
//
//   @override
//   State<Posts> createState() => _PostState();
// }
//
// class _PostState extends State<Posts> {
//   CollectionReference posts = FirebaseFirestore.instance.collection("posts");
//   // final fa.FirebaseAuth _auth = fa.FirebaseAuth.instance;
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   // User? myself,contact;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Posts"),
//         actions: <Widget>[
//           IconButton(
//               icon: const Icon(
//                 Icons.sentiment_satisfied_alt,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 // Navigator.of(context).push(MaterialPageRoute(builder:
//                 //     (BuildContext context) => RatingDialog(contactUID: id(),)));
//               })
//         ],
//       ),
//       body: StreamBuilder(
//           stream: _db
//               .collection('posts')
//               .doc('recipe')
//               .collection('UserName')
//               .snapshots(),
//           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return const Text("Something went wrong querying users");
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (snapshot.hasData) {
//               if (snapshot.data!.docs.isEmpty) {
//                 return const Text("No record");
//               } else {
//                 return ListView.builder(
//                   padding: const EdgeInsets.all(10.0),
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       DocumentSnapshot doc = snapshot.data!.docs[index];
//                       Post post = Post.fromJson(
//                           doc.id, doc.data() as Map<String, dynamic>);
//                       return Container(
//                         padding: const EdgeInsets.only(
//                             left: 14, right: 14, top: 5, bottom: 5),
//                         child: Align(
//                           alignment: (Alignment.topLeft),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25),
//                               color: (Colors.grey.shade200),
//                             ),
//                             padding: const EdgeInsets.all(10),
//                             child: Text(post.post, style: const TextStyle(
//                                 fontSize: 15),),
//                           ),
//                         ),
//                       );
//                     });
//               }
//             } else {
//               return Text("no data");
//             }
//           })
//     );
//   }
//   List<Post> post = [];
//   void getStreams() async {
//     _db.collection("posts")
//         .doc("recipe")
//         .collection("UserName")
//         .snapshots()
//         .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
//       snapshot.docs.map((QueryDocumentSnapshot doc) {
//         post.add(
//             Post.fromJson(doc.id, doc.data() as Map<String, dynamic>));
//       });
//     });
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class displayPost extends StatelessWidget {
  displayPost({
    required this.recipes, required this.user_id,
  });

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _postRef = FirebaseFirestore.instance.collection(
      "posts");
  final _message = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String recipes;
  final String user_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Display Posts"),
        ),
        body: StreamBuilder(
            stream: _db
                .collection('posts')
                .doc(recipes)
                .collection(user_id)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                print(snapshot.data!.docs.length);
                if (snapshot.data!.docs.isEmpty){
                  return const Text("No record");
                } else {
                  return ListView.builder(
                      padding: const EdgeInsets.all(10.0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index){
                        DocumentSnapshot doc = snapshot.data!.docs[index];
                        Post post = Post.fromJson(doc.data() as Map<String, dynamic>);
                        String currPost = post.post;
                        return Text(currPost);
                      });
                }
              } else {
                return const Text("no record");
              }
            })
    );
  }

  List<Post> post = [];
  void getStreams() async {
    _db.collection("posts")
        .doc(recipes)
        .collection(user_id)
        .snapshots()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      snapshot.docs.map((QueryDocumentSnapshot doc) {
        post.add(
            Post.fromJson(doc.data() as Map<String, dynamic>));
      });
    });
  }
}
