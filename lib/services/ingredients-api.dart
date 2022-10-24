import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:what2bake/services/client.dart';

class IngredientsApi extends StatefulWidget {

  late int type; // Type of the product
  IngredientsApi(this.type, {super.key} );
  @override
  State<IngredientsApi> createState() => _IngredientsApiState();
}

class _IngredientsApiState extends State<IngredientsApi> {

  String readRepositories = """
      query{
        allProducts{
          id,
          name
        }
      }
  """;

  List isSelected = [for (var i = 0; i < 500; i++) false];

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

          List? products = result.data?['allProducts'];


          if (products == null) {
            return const Text('No products');
          }

          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF393838),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const CircleAvatar(),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Warzywa & owoce',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Lato',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${isSelected.where((e) => e == true).length}/${products.length} składników',
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Lato',
                                color: Color(0xFFB7B7B7),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: const Color(0xFF232323),
                  height: 3,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          spacing: 10,
                          runSpacing: 0,
                          children: [for (var i = 0; i < products.length; i++) TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: isSelected[i] ? const Color(0xFF607C08) : const Color(0xFF505050),
                            ),
                            onPressed: () {
                              setState(() {
                                isSelected[i] = !isSelected[i];
                              });
                            },
                            child: Text(
                                products[i]['name'],
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD1D1D1),
                                ),
                              ),
                            )].toList(),
                        ),
                      ),
                    ),
                  )
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
