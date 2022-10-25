import 'package:flutter/material.dart';
import 'package:what2bake/services/api.dart';
import 'package:what2bake/widgets/appbar.dart';
import 'package:what2bake/services/model.dart';

class RecipesApi extends StatefulWidget {
  const RecipesApi({Key? key}) : super(key: key);

  @override
  State<RecipesApi> createState() => _RecipesApiState();
}

class _RecipesApiState extends State<RecipesApi> {

  @override
  void initState() {
    super.initState();
  }

  List<dynamic> recipes = [];
  Future<dynamic> future = getRecipes(0);

  @override
  Widget build(BuildContext context) {
    const someOtherSliver = Appbar();

    return FutureBuilder<dynamic>(
      future: future,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        Widget newsListSliver;
        if (snapshot.hasData) {
          recipes = snapshot.data;
          newsListSliver = SliverPadding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              sliver: SliverGrid(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 220,
                                ),
                                delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF393838),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.fitWidth,
                                                    image: NetworkImage(recipes[index].image)
                                                  ),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                child: Text(
                                                    recipes[index].title,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontFamily: 'Lato',
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                )
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                                  alignment: Alignment.topLeft,
                                                  child: const Text(
                                                    "Informacja o dostepnosci",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.green,
                                                        fontFamily: 'Lato',
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  )
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  childCount: recipes.length,
                                ),
                              ),
                            );
        } else {
          newsListSliver = SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            sliver: SliverGrid(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF393838),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                childCount: 1,
                              ),
                            ),
                          );
        }
        return CustomScrollView(
              slivers: [
                someOtherSliver,
                newsListSliver
              ]
        );
      },
    );
  }
}