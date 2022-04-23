// import 'package:final_project/recipes.dart';
// import 'package:final_project/recipes_api.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class displayRecipes extends StatefulWidget {
//   const displayRecipes({Key? key}) : super(key: key);
//
//   @override
//   State<displayRecipes> createState() => _displayRecipesState();
// }
//
// class _displayRecipesState extends State<displayRecipes> {
//   List<Recipe>? recipes;
//   var isLoaded = false;
//
//   @override
//   void initState(){
//     super.initState();
//     getData();
//   }
//
//   getData() async {
//     recipes = (await api().getRecipes()) as List<Recipe>?;
//     if (recipes != null) {
//       setState(() {
//         isLoaded = true;
//       });
//     }
//     print(recipes);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Recipes'),
//       ),
//       body: Visibility(
//         visible: isLoaded,
//           child: ListView.builder(
//             itemCount: recipes?.length,
//             itemBuilder: (context,index){
//               return Container(
//                 child: Text("recipes![index].label"),
//               );
//             },
//           ),
//         replacement: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       )
//     );
//   }
// }

//-------



import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  final String postUrl;
  RecipeView({required this.postUrl});

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  late String finalUrl ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finalUrl = widget.postUrl;
    if(widget.postUrl.contains('http://')){
      finalUrl = widget.postUrl.replaceAll("http://","https://");
      print(finalUrl + "this is final url");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: Platform.isIOS? 60: 30, right: 24,left: 24,bottom: 16),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xff213A50),
                          Color(0xff071930)
                        ],
                        begin: FractionalOffset.topRight,
                        end: FractionalOffset.bottomLeft)),
                child:  Row(
                  mainAxisAlignment: kIsWeb
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "AppGuy",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Overpass'),
                    ),
                    Text(
                      "Recipes",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontFamily: 'Overpass'),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - (Platform.isIOS ? 104 : 30),
                width: MediaQuery.of(context).size.width,
                child: WebView(
                  onPageFinished: (val){
                    print(val);
                  },
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: finalUrl,
                  onWebViewCreated: (WebViewController webViewController){
                    setState(() {
                      _controller.complete(webViewController);
                    });
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}