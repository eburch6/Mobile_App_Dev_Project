import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/post_recipes.dart';
import 'package:final_project/rate.dart';
import 'package:final_project/recipe_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'display_recipes.dart';
import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<RecipeModel> recipies = [];
  late String ingridients;
  bool _loading = false;
  String query = "";
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe App"),
        backgroundColor: const Color(0xff213A50),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder:
                    (BuildContext context) => postRecipes()));
              })],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xff213A50),
                      Color(0xff071930)
                    ],
                    begin: FractionalOffset.topRight,
                    end: FractionalOffset.bottomLeft)),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: !kIsWeb ? Platform.isIOS? 60: 30 : 30, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Search your recipe here...",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Overpass'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: textEditingController,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Overpass'),
                            decoration: InputDecoration(
                              hintText: "Enter Ingridients",
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.5),
                                  fontFamily: 'Overpass'),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () async {
                              if (textEditingController.text.isNotEmpty) {
                                setState(() {
                                  _loading = true;
                                });
                                recipies = [];
                                String url =
                                    "https://api.edamam.com/search?q=${textEditingController.text}&app_id=75862168&app_key=eaa751eb66608b026e8916cd01aa2414";
                                var response = await http.get(Uri.parse(url));
                                // print(" $response this is response");
                                Map<String, dynamic> jsonData =
                                jsonDecode(response.body);
                                // print("this is json Data $jsonData");
                                jsonData["hits"].forEach((element) {
                                  // print(element.toString());
                                  RecipeModel recipeModel;
                                  recipeModel =
                                      RecipeModel.fromMap(element['recipe']);
                                  recipies.add(recipeModel);
                                  // print(recipeModel.url);
                                });
                                setState(() {
                                  _loading = false;
                                });
                              } else {
                                print("None");
                              }
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  // borderRadius: BorderRadius.circular(8),
                                  // gradient: LinearGradient(
                                  //     colors: [
                                  //       Color(0xffA2834D),
                                  //       Color(0xffBC9A5F)
                                  //     ],
                                  //     begin: FractionalOffset.topRight,
                                  //     end: FractionalOffset.bottomLeft)
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const <Widget>[
                                  Icon(
                                      Icons.search,
                                      size: 30,
                                      color: Colors.white
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: GridView(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 10.0, maxCrossAxisExtent: 200.0),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const ClampingScrollPhysics(),
                        children: List.generate(recipies.length, (index) {
                          return GridTile(
                              child: RecipieTile(
                                title: recipies[index].label,
                                imgUrl: recipies[index].image,
                                desc: recipies[index].source,
                                url: recipies[index].url,
                              ),
                              footer: GridTileBar(
                                backgroundColor: Colors.black54,
                                leading: LikeButton(
                                  size: 30,
                                  // likeCount: 0,
                                  likeBuilder: (bool like) {
                                    return const Icon(
                                      // padding: EdgeInsets.all(4.0),
                                      // child: Icon(
                                      Icons.thumb_up,
                                      color: Colors.red,
                                    // ),
                                    );
                                  },
                                ),
                                // leading: IconButton(
                                //     icon: const Icon(
                                //       Icons.star,
                                //       color: Colors.grey,
                                //     ),
                                //     onPressed: () {
                                      // Navigator.of(context).push(MaterialPageRoute(builder:
                                      //     (BuildContext context) => login()));
                                //     }
                                // ),
                                title: IconButton(
                                    icon: const Icon(
                                      Icons.tag_faces,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder:
                                          (BuildContext context) => RatingDialog(recipe_name: "RecipieTile.title")));
                                    }),
                              ),
                          );
                        })),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RecipieTile extends StatefulWidget {
  final String title, desc, imgUrl, url;

  const RecipieTile({required this.title, required this.desc, required this.imgUrl, required this.url});

  @override
  _RecipieTileState createState() => _RecipieTileState();
}

class _RecipieTileState extends State<RecipieTile> {
  void _launchURL() async {
    final Uri _url = Uri.parse('https://flutter.dev');
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _launchURL();
            // if (kIsWeb) {
            //   _launchURL(widget.url);
            // } else {
            //   print(widget.url + " this is what we are going to see");
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => RecipeView(
            //             postUrl: widget.url,
            //           )));
            // }

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => postRecipes(recipes: title)));
          },
          child: Container(
            margin: EdgeInsets.all(5),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imgUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black54, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                              // fontFamily: 'Overpass'
                          ),
                        ),
                        Text(
                          widget.desc,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                              // fontFamily: 'OverpassRegular'
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GradientCard extends StatelessWidget {
  final Color topColor;
  final Color bottomColor;
  final String topColorCode;
  final String bottomColorCode;

  GradientCard(
      {required this.topColor,
        required this.bottomColor,
        required this.topColorCode,
        required this.bottomColorCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Wrap(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 160,
                  width: 180,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [topColor, bottomColor],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight)),
                ),
                Container(
                  width: 180,
                  alignment: Alignment.bottomLeft,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          topColorCode,
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          bottomColorCode,
                          style: TextStyle(fontSize: 16, color: bottomColor),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}