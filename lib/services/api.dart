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
        document: gql(_getAllProducts)
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

Future<List<Recipe>> getRecipes(int page) async {
  final prefs = await SharedPreferences.getInstance();
  var products = prefs.getStringList('0')!.map(int.parse).toList();

  if(products.isEmpty) {
    products = [-1];
  }

  var result = await client.query(
    QueryOptions(
      document: gql(_getRecipes),
      variables: {
        "page": page,
        "products": products,
        "productOrder": "MOST",
        "orderDirection": "DESC"
        }
    )
  );

  var json = result.data!["allRecipes"];
  print(json);
  List<Recipe> recipes = [];
  for (var res in json) {
    recipes.add(Recipe.fromJson(res));
  }
  return recipes;
}

const _getAllProducts= """
      query{
        allProducts{
          id,
          name
        }
      }
  """;

const _getRecipes = """
    query RecipiesWithFilters(\$page: Int!, \$products: [Int]!, \$productOrder: productOrder!, \$orderDirection: orderDirection!) {
      allRecipes(filter: {page: \$page, products: \$products, productOrder: \$productOrder, orderDirection: \$orderDirection}){
        title,
        image,
        link
      }
    }
  """;