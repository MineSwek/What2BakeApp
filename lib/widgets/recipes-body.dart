import 'package:flutter/material.dart';
import 'package:what2bake/widgets/appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:what2bake/services/api.dart';

class RecipesBody extends StatefulWidget {
  const RecipesBody({super.key});

  @override
  State<RecipesBody> createState() => _RecipesBodyState();
}

class _RecipesBodyState extends State<RecipesBody> {

  @override
  void initState() {
    super.initState();
  }

  List<dynamic> recipes = [];
  List<int> similarity = [];
  List<int> products = [];
  Future future = getRecipes(0);

  @override
  Widget build(BuildContext context) {
    const someOtherSliver = Appbar();

    return FutureBuilder<dynamic>(
      future: future,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        Widget newsListSliver;
        if (snapshot.hasData) {
          recipes = snapshot.data[0];
          similarity = snapshot.data[1];
          products = snapshot.data[2];

          newsListSliver = SliverPadding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              sliver: SliverGrid(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 220,
                                ),
                                delegate: SliverChildBuilderDelegate( (context, index) {

                                  String sim;
                                  Color col;
                                  if(similarity[index] == 0) {
                                    sim = "Posiadasz wszystko!";
                                    col = const Color(0xFF009D10);
                                  } else if(similarity[index] == recipes[index].products.length) {
                                    sim = "Brak składników";
                                    col = const Color(0xFFA56300);
                                  } else {
                                    sim = "Brakuje ci ${similarity[index]} składników";
                                    col = Colors.amber;
                                  }

                                  int howManyProducts = 0;
                                  for(var i = 0; i < products.length; i++) {
                                    for(var j = 0; j < recipes[index].products.length; j++) {
                                      if(recipes[index].products[j].id == products[i].toString()) howManyProducts += 1;
                                    }

                                  }

                                  final ScrollKontroler = ScrollController();
                                  return GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              backgroundColor: const Color(0xFF242323),
                                              insetPadding: const EdgeInsets.symmetric(vertical: 90, horizontal: 15),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 4,
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                          fit: BoxFit.fitWidth,
                                                          image: NetworkImage(recipes[index].image)
                                                          ),
                                                          borderRadius: BorderRadius.circular(10),
                                                        )
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        decoration: const BoxDecoration(
                                                          color: Color(0xFF302F2F)
                                                        ),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Container(
                                                                margin: const EdgeInsets.only(top: 10),
                                                                height: 47,
                                                                width: 257,
                                                                child: TextButton(
                                                                  style: TextButton.styleFrom(
                                                                    backgroundColor: Colors.amber,
                                                                  ),
                                                                  onPressed: () {
                                                                    setState(() async {
                                                                      await launch(recipes[index].link);
                                                                    });
                                                                  },
                                                                  child: const Text(
                                                                    'Zobacz przepis',
                                                                    style: TextStyle(
                                                                      fontSize: 17,
                                                                      fontFamily: 'Lato',
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: const EdgeInsets.only(top: 10),
                                                                child: Text(
                                                                  recipes[index].title,
                                                                  style: const TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.w900,
                                                                    fontFamily: 'Lato',
                                                                    color: Colors.white
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,

                                                      child: Container(
                                                        margin: const EdgeInsets.all(10),
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
                                                                  SvgPicture.asset(
                                                                      'assets/categories/1.svg',
                                                                    width: 40,
                                                                  ),
                                                                  Container(
                                                                    margin: const EdgeInsets.only(left: 15),
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        const Text(
                                                                          'Składniki',
                                                                          style: TextStyle(
                                                                            fontSize: 20,
                                                                            fontFamily: 'Lato',
                                                                            color: Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${howManyProducts.toString()}/${recipes[index].products.length} składników',
                                                                          style: const TextStyle(
                                                                            fontSize: 15,
                                                                            fontFamily: 'Lato',
                                                                            color: Color(0xFFB7B7B7),
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              color: const Color(0xFF232323),
                                                              height: 3,
                                                            ),
                                                            Expanded(
                                                              flex: 3,
                                                              child: Scrollbar(
                                                                controller: ScrollKontroler,
                                                                thumbVisibility: true,
                                                                child: SingleChildScrollView(
                                                                  controller: ScrollKontroler,
                                                                  scrollDirection: Axis.vertical,
                                                                  child: Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(10),
                                                                      child: Wrap(
                                                                          crossAxisAlignment: WrapCrossAlignment.start,
                                                                          alignment: WrapAlignment.start,
                                                                          spacing: 10,
                                                                          runSpacing: 10,
                                                                          children: [for (var i = 0; i < recipes[index].products.length; i++) Container(
                                                                            padding: const EdgeInsets.all(10),
                                                                            decoration: BoxDecoration(
                                                                              color: products.contains(int.parse(recipes[index].products[i].id)) ? const Color(0xFF607C08) : const Color(0xFF505050),
                                                                              borderRadius: BorderRadius.circular(5),
                                                                            ),
                                                                            child: Text(
                                                                              recipes[index].products[i].name,
                                                                              style: const TextStyle(
                                                                                fontSize: 15,
                                                                                fontFamily: 'Lato',
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Color(0xFFD1D1D1),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          ]
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ]
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
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
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.topLeft,
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
                                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  sim,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: col,
                                                      fontFamily: 'Lato',
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
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
                                  return const Center(
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