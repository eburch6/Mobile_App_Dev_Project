// import 'dart:convert';
//
// import 'package:final_project/recipes.dart';
// // import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
//
// class api {
//   Future<Recipe?> getRecipes() async {
//     var client = http.Client();
//     var uri = Uri.parse('https://api.edamam.com/search?app_id=75862168&app_key=eaa751eb66608b026e8916cd01aa2414%09&q=pizza');
//     // api example
//     // var uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
//     var response = await client.get(uri);
//     if (response.statusCode == 200){
//       var json = response.body;
//       return RecipeFromJson(json);
//
//     }
//     return null;
//   }
// }

// class api {
//   Future<List<Recipes>> getRecipes(http.Client client) async {
//     var uri = "https://api.edamam.com/search?app_id=75862168&app_key=eaa751eb66608b026e8916cd01aa2414%09&q=pizza";
//     final response = await client.get(Uri.parse(uri));
//     return compute(parseRecipes, response.body);
//   }
//
//   List<Recipes> parseRecipes(String responseBody){
//     final parsed = jsonDecode(responseBody).cast<Map<String,dynamic>>();
//     return parsed.map<Recipes>((json) => Recipes.fromJson(json)).toList();
//   }
// }



import 'dart:convert';
import 'package:http/http.dart' as http;

import 'hits.dart';

class Recipie {
  List<Hits> hits = [];

  Future<void> getReceipe() async {
    var client = http.Client();
    var url =
        "https://api.edamam.com/search?q=banana&app_id=75862168&app_key=eaa751eb66608b026e8916cd01aa2414";
    var response = await client.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    jsonData["hits"].forEach((element) {
      Hits hits = Hits(
        recipeModel: element['recipe'],
      );
      // hits.recipeModel = add(Hits.fromMap(hits.recipeModel));
    });
  }
}
