class Recipe {
  String? title;
  String? image;
  String? link;
  List<Product>? products;

  Recipe({this.title, this.image, this.link, this.products});

  Recipe.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    link = json['link'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }

}

class Product {
  late String id;
  late String name;
  Category? category;
  Product({required this.id, required this.name, this.category});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
  }

}

class Category {
  String? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}