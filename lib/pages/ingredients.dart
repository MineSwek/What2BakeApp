import 'package:flutter/material.dart';
import 'package:what2bake/services/api.dart';
import 'package:what2bake/services/model.dart';
import 'package:what2bake/widgets/appbar.dart';
import 'package:what2bake/widgets/ingredients-body.dart';

class Ingredients extends StatefulWidget {
  const Ingredients({Key? key}) : super(key: key);

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {

  List<dynamic> productsApi = [];
  List<dynamic> categories = [];
  List<String> pressed = [];
  late Future _allproducts;

  @override
  void initState() {
    _allproducts = getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const someOtherSliver = Appbar();

    return Scaffold(
      backgroundColor: const Color(0xFF232323),
      body: FutureBuilder<dynamic>(
        future: _allproducts,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          Widget newListSliver;
          if(snapshot.hasData) {
            productsApi = snapshot.data[0];
            categories = snapshot.data[2];
            pressed = snapshot.data[1];
            categories.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
            Map<String, List<dynamic>> products = {};
            categories.forEach((e) {
              List<Product> temp = [];
              List<String> temp2 = [];
              productsApi.forEach((e2) {
                if(e2.category.id == e.id) {
                  pressed.forEach((e3) {
                    if(e3 == e2.id) temp2.add(e3);
                  });
                  temp.add(e2);
                }
              });
              products[e.id] = [temp, temp2];
            });



            newListSliver =  SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisExtent: 260

                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: IngredientsBody(products: products[(index+1).toString()]![0], pressed: pressed, pressedNumber: products[(index+1).toString()]![1].length),
                    );
                  },
                  childCount: categories.length,
                ),
              ),
            );
          } else {
            newListSliver = SliverPadding(
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
              newListSliver
            ],
          );
        }
      ),
    );
  }
}
