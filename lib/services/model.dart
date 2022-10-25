class Product {
  String id;
  String name;

  Product.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}

class Recipe {
  String image;
  String title;
  String link;

  Recipe.fromJson(Map<String, dynamic> json)
      : image = json["image"],
        title = json["title"],
        link = json["link"];
}