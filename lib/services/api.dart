import 'package:what2bake/services/model.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

const baseURL = "http://130.61.8.73:8080/graphql";

final _httpLink = HttpLink(
  baseURL,
);

final GraphQLClient client = GraphQLClient(
  link: _httpLink,
  cache: GraphQLCache(),
);

Future<dynamic> getAllProducts() async {
  var result = await client.query(
    QueryOptions(
        document: gql(_getAllProducts),
        variables: const {
            "productOrder": ["ALPHABETIC_ASC"]
        }
    ),
  );
  final prefs = await SharedPreferences.getInstance();
  var pressed = prefs.getStringList('0')!;

  if(result.hasException) {
    throw result.exception!;
  }
  var json = result.data!["allProducts"];
  List<Product> products = [];

  for (var res in json) {
    products.add(Product.fromJson(res));
  }
  return [products, pressed];
}

Future<dynamic> getRecipes(int page) async {
  final prefs = await SharedPreferences.getInstance();
  var products = prefs.getStringList('0')!.map(int.parse).toList();

  if(products.isEmpty) {
    products = [0];
  }

  var result = await client.query(
    QueryOptions(
      document: gql(_getRecipes),
      variables: {
        "page": page,
        "products": products,
        "productOrder": const ["MOST", "LEAST"]
        }
    )
  );

  List response = result.data!["allRecipes"];
  List recipes = [];
  List<int> similarity = [];
  for (var res in response) {
    var temp = Recipe.fromJson(res);
    var temp2 = 0;
    for(var i = 0; i < temp.products!.length; i++) {
      if(products.contains(int.parse(temp.products![i].id))) {
        temp2++;
      }
    }
    recipes.add(temp);
    similarity.add((temp2 - temp.products!.length).abs());
  }
  return [recipes, similarity, products];
}

const _getAllProducts= """
      query ProductsWithFilters(\$productOrder: [productOrder]!){
        allProducts(filter: {productOrder: \$productOrder}){
          id,
          name
        }
      }
  """;

const _getRecipes = """
    query RecipiesWithFilters(\$page: Int!, \$products: [Int]!, \$productOrder: [recipeProductOrder]!) {
      allRecipes(filter: {page: \$page, products: \$products, productOrder: \$productOrder}){
        title,
        image,
        link,
        products {
          id,
          name
        }
      }
  }
  """;