import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:what2bake/services/client.dart';

class RecipesApi extends StatefulWidget {
  const RecipesApi({Key? key}) : super(key: key);

  @override
  State<RecipesApi> createState() => _RecipesApiState();
}

class _RecipesApiState extends State<RecipesApi> {

  String readRepositories = """
    query{
      allRecipes(filter:{}) {
        id,
        title,
        link,
      } 
    }
  """;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Api().client(),
      child: Query(
        options: QueryOptions(
          document: gql(readRepositories),
        ),
        builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Text('Loading...');
          }

          List? recipes = result.data?['allRecipes'];

          if (recipes == null) {
            return const Text('No recipes');
          }

          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  childCount: recipes.length,
                      (context, index) {
                    final recipe = recipes[index];
                    return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF393838),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(recipe['id'] + ' ' + recipe['title'] + ' ' + recipe['link'], style: const TextStyle(color: Colors.amber),) //'Placeholder $index'
                    );
                  },
                ),
              ),

          );
        },
      ),
    );
  }
}