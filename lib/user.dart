
class User {
  final String id;
  final String username;
  final String email;
  final String message;
  final int rating;
  final String recipes;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.message,
      required this.rating,
      required this.recipes,});

  User.fromJson(String id, Map<String, dynamic> json)
      : this(
            id: id,
            username: json["username"],
            email: json["email"],
            message: json["message"],
            rating: json["rating"],
            recipes: json["recipes"]);

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "message": message,
      "rating": rating,
      "recipes": recipes,
    };
  }
}
