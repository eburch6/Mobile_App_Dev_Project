// import 'dart:convert';


// List<Recipes> postFromJson(String str) => List<Recipes>.from(json.decode(str).map((x) => Recipes.fromJson(x)));
//
// String postToJason(List<Recipes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class Recipes {
//   Recipes
//   ({
//     required this.recipe,
//     required this.label,
//     required this.uri,
//     required this.image,
//     required this.ingredientLines,
//     required this.calories,
//   });
//
//   String recipe;
//   String label;
//   String uri;
//   String image;
//   String ingredientLines;
//   String calories;
//
//   factory Recipes.fromJson(Map<String, dynamic> json) => Recipes(
//     recipe: json["recipe"],
//     label: json["label"],
//     uri: json["uri"],
//     image: json["image"],
//     ingredientLines: json["ingredientLines"],
//     calories: json["calories"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "recipe": recipe,
//     "label": label,
//     "uri": uri,
//     "image": image,
//     "ingredientLines": ingredientLines,
//     "calories": calories,
//   };
// }
//
// ----- sample -----
// class Recipes {
//   Recipes
//       ({
//     required this.userId,
//     required this.id,
//     required this.title,
//     required this.body,
//   });
//
//   int userId;
//   int id;
//   String title;
//   String body;
//
//   factory Recipes.fromJson(Map<String, dynamic> json) => Recipes(
//     userId: json["userId"],
//     id: json["id"],
//     title: json["title"],
//     body: json["body"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "userId": userId,
//     "id": id,
//     "title": title,
//     "body": body,
//   };
// }
// --------- sample --------

// import 'dart:convert';
//
// Recipe RecipeFromJson(String str) => Recipe.fromJson(json.decode(str));
//
// String RecipeToJson(Recipe data) => json.encode(data.toJson());

// class Recipes {
//   Recipes({
//     required this.from,
//     required this.to,
//     required this.count,
//     required this.links,
//     required this.hits,
//   });
//
//   int from;
//   int to;
//   int count;
//   Links links;
//   List<Hit> hits;
//
//   factory Recipes.fromJson(Map<String, dynamic> json) => Recipes(
//     from: json["from"],
//     to: json["to"],
//     count: json["count"],
//     links: Links.fromJson(json["_links"]),
//     hits: List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "from": from,
//     "to": to,
//     "count": count,
//     "_links": links.toJson(),
//     "hits": List<dynamic>.from(hits.map((x) => x.toJson())),
//   };
// }
//
// class Hit {
//   Hit({
//     required this.recipe,
//     required this.links,
//   });
//
//   Recipe recipe;
//   Links links;
//
//   factory Hit.fromJson(Map<String, dynamic> json) => Hit(
//     recipe: Recipe.fromJson(json["recipe"]),
//     links: Links.fromJson(json["_links"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "recipe": recipe.toJson(),
//     "_links": links.toJson(),
//   };
// }
//
// class Links {
//   Links({
//     required this.self,
//     required this.next,
//   });
//
//   Next self;
//   Next next;
//
//   factory Links.fromJson(Map<String, dynamic> json) => Links(
//     self: Next.fromJson(json["self"]),
//     next: Next.fromJson(json["next"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "self": self.toJson(),
//     "next": next.toJson(),
//   };
// }
//
// class Next {
//   Next({
//     required this.href,
//     required this.title,
//   });
//
//   String href;
//   String title;
//
//   factory Next.fromJson(Map<String, dynamic> json) => Next(
//     href: json["href"],
//     title: json["title"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "href": href,
//     "title": title,
//   };
// }

// class Recipe {
//   Recipe({
//     required this.uri,
//     required this.label,
//     required this.image,
//     required this.images,
//     required this.source,
//     required this.url,
//     required this.shareAs,
//     required this.recipeYield,
//     required this.dietLabels,
//     required this.healthLabels,
//     required this.cautions,
//     required this.ingredientLines,
//     required this.ingredients,
//     required this.calories,
//     required this.glycemicIndex,
//     required this.totalCo2Emissions,
//     required this.co2EmissionsClass,
//     required this.totalWeight,
//     required this.cuisineType,
//     required this.mealType,
//     required this.dishType,
//     required this.totalNutrients,
//     required this.totalDaily,
//     required this.digest,
//   });
//
//   String? uri;
//   String? label;
//   String? image;
//   Images images;
//   String? source;
//   String? url;
//   String? shareAs;
//   int? recipeYield;
//   List<String> dietLabels;
//   List<String> healthLabels;
//   List<String> cautions;
//   List<String> ingredientLines;
//   List<Ingredient> ingredients;
//   int? calories;
//   int? glycemicIndex;
//   int? totalCo2Emissions;
//   String? co2EmissionsClass;
//   int? totalWeight;
//   List<String> cuisineType;
//   List<String> mealType;
//   List<String> dishType;
//   TotalDaily totalNutrients;
//   TotalDaily totalDaily;
//   List<Digest> digest;
//
//   factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
//     uri: json["uri"],
//     label: json["label"],
//     image: json["image"],
//     images: Images.fromJson(json["images"]),
//     source: json["source"],
//     url: json["url"],
//     shareAs: json["shareAs"],
//     recipeYield: json["yield"],
//     dietLabels: List<String>.from(json["dietLabels"].map((x) => x)),
//     healthLabels: List<String>.from(json["healthLabels"].map((x) => x)),
//     cautions: List<String>.from(json["cautions"].map((x) => x)),
//     ingredientLines: List<String>.from(json["ingredientLines"].map((x) => x)),
//     ingredients: List<Ingredient>.from(json["ingredients"].map((x) => Ingredient.fromJson(x))),
//     calories: json["calories"],
//     glycemicIndex: json["glycemicIndex"],
//     totalCo2Emissions: json["totalCO2Emissions"],
//     co2EmissionsClass: json["co2EmissionsClass"],
//     totalWeight: json["totalWeight"],
//     cuisineType: List<String>.from(json["cuisineType"].map((x) => x)),
//     mealType: List<String>.from(json["mealType"].map((x) => x)),
//     dishType: List<String>.from(json["dishType"].map((x) => x)),
//     totalNutrients: TotalDaily.fromJson(json["totalNutrients"]),
//     totalDaily: TotalDaily.fromJson(json["totalDaily"]),
//     digest: List<Digest>.from(json["digest"].map((x) => Digest.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "uri": uri,
//     "label": label,
//     "image": image,
//     "images": images.toJson(),
//     "source": source,
//     "url": url,
//     "shareAs": shareAs,
//     "yield": recipeYield,
//     "dietLabels": List<dynamic>.from(dietLabels.map((x) => x)),
//     "healthLabels": List<dynamic>.from(healthLabels.map((x) => x)),
//     "cautions": List<dynamic>.from(cautions.map((x) => x)),
//     "ingredientLines": List<dynamic>.from(ingredientLines.map((x) => x)),
//     "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
//     "calories": calories,
//     "glycemicIndex": glycemicIndex,
//     "totalCO2Emissions": totalCo2Emissions,
//     "co2EmissionsClass": co2EmissionsClass,
//     "totalWeight": totalWeight,
//     "cuisineType": List<dynamic>.from(cuisineType.map((x) => x)),
//     "mealType": List<dynamic>.from(mealType.map((x) => x)),
//     "dishType": List<dynamic>.from(dishType.map((x) => x)),
//     "totalNutrients": totalNutrients.toJson(),
//     "totalDaily": totalDaily.toJson(),
//     "digest": List<dynamic>.from(digest.map((x) => x.toJson())),
//   };
// }
//
// class Digest {
//   Digest({
//     required this.label,
//     required this.tag,
//     required this.schemaOrgTag,
//     required this.total,
//     required this.hasRdi,
//     required this.daily,
//     required this.unit,
//     required this.sub,
//   });
//
//   String label;
//   String tag;
//   String schemaOrgTag;
//   int total;
//   bool hasRdi;
//   int daily;
//   String unit;
//   TotalDaily sub;
//
//   factory Digest.fromJson(Map<String, dynamic> json) => Digest(
//     label: json["label"],
//     tag: json["tag"],
//     schemaOrgTag: json["schemaOrgTag"],
//     total: json["total"],
//     hasRdi: json["hasRDI"],
//     daily: json["daily"],
//     unit: json["unit"],
//     sub: TotalDaily.fromJson(json["sub"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "label": label,
//     "tag": tag,
//     "schemaOrgTag": schemaOrgTag,
//     "total": total,
//     "hasRDI": hasRdi,
//     "daily": daily,
//     "unit": unit,
//     "sub": sub.toJson(),
//   };
// }
//
// class TotalDaily {
//   TotalDaily();
//
//   factory TotalDaily.fromJson(Map<String, dynamic> json) => TotalDaily(
//   );
//
//   Map<String, dynamic> toJson() => {
//   };
// }
//
// class Images {
//   Images({
//     required this.thumbnail,
//     required this.small,
//     required this.regular,
//     required this.large,
//   });
//
//   Large thumbnail;
//   Large small;
//   Large regular;
//   Large large;
//
//   factory Images.fromJson(Map<String, dynamic> json) => Images(
//     thumbnail: Large.fromJson(json["THUMBNAIL"]),
//     small: Large.fromJson(json["SMALL"]),
//     regular: Large.fromJson(json["REGULAR"]),
//     large: Large.fromJson(json["LARGE"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "THUMBNAIL": thumbnail.toJson(),
//     "SMALL": small.toJson(),
//     "REGULAR": regular.toJson(),
//     "LARGE": large.toJson(),
//   };
// }
//
// class Large {
//   Large({
//     required this.url,
//     required this.width,
//     required this.height,
//   });
//
//   String url;
//   int width;
//   int height;
//
//   factory Large.fromJson(Map<String, dynamic> json) => Large(
//     url: json["url"],
//     width: json["width"],
//     height: json["height"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "url": url,
//     "width": width,
//     "height": height,
//   };
// }
//
// class Ingredient {
//   Ingredient({
//     required this.text,
//     required this.quantity,
//     required this.measure,
//     required this.food,
//     required this.weight,
//     required this.foodId,
//   });
//
//   String text;
//   int quantity;
//   String measure;
//   String food;
//   int weight;
//   String foodId;
//
//   factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
//     text: json["text"],
//     quantity: json["quantity"],
//     measure: json["measure"],
//     food: json["food"],
//     weight: json["weight"],
//     foodId: json["foodId"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "text": text,
//     "quantity": quantity,
//     "measure": measure,
//     "food": food,
//     "weight": weight,
//     "foodId": foodId,
//   };
// }

//-----recipe example -----


