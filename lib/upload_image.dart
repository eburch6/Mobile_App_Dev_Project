// //
// import 'dart:html';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path/path.dart';
//
// class uploadImage extends StatefulWidget {
//   const uploadImage({Key? key}) : super(key: key);
//
//   @override
//   State<uploadImage> createState() => _uploadImageState();
// }
//
// class _uploadImageState extends State<uploadImage> {
//   String? imageUrl;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Upload Image'),
//           backgroundColor: Colors.white,
//         ),
//         body: Container(
//           color: Colors.white,
//           child: Column(
//             children: <Widget>[
//               Container(
//                   margin: const EdgeInsets.all(15),
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(15),
//                     ),
//                     border: Border.all(color: Colors.white),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black12,
//                         offset: Offset(2, 2),
//                         spreadRadius: 2,
//                         blurRadius: 1,
//                       ),
//                     ],
//                   ),
//                   child: (imageUrl != null)
//                       ? Image.network(imageUrl!)
//                       : Image.network('https://i.imgur.com/sUFH1Aq.png')),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               // ignore: deprecated_member_use
//       ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => upload_image()));
//           },
//           child: const Text("Register")),
//             ],
//           ),
//         ));
//   }
//
//   upload_image() async {
//     final _firebaseStorage = FirebaseStorage.instance;
//     final _imagePicker = ImagePicker();
//     // PickedFile? image;
//     XFile? image;
//     //Check Permissions
//     await Permission.photos.request();
//
//     var permissionStatus = await Permission.photos.status;
//
//     if (permissionStatus.isGranted){
//       //Select Image
//       image = await _imagePicker.pickImage(source: ImageSource.gallery);
//       // final appDir = await syspaths.getApplicationDocumentsDirectory();
//       // final fileName = path.basename(image?.path);
//       var file = File(image?.path);
//
//       if (image != null){
//         //Upload to Firebase
//         var snapshot = await _firebaseStorage.ref()
//             .child('images/imageName')
//             .putFile(file).onComplete;
//         var downloadUrl = await snapshot.ref.getDownloadURL();
//         setState(() {
//           imageUrl = downloadUrl;
//         });
//       } else {
//         print('No Image Path Received');
//       }
//     } else {
//       print('Permission not granted. Try Again with permission access');
//     }
//   }
//
// }


