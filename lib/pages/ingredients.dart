import 'package:flutter/material.dart';
import 'package:what2bake/widgets/appbar.dart';
import 'package:what2bake/services/ingredients-api.dart';

class Ingredients extends StatefulWidget {
  const Ingredients({Key? key}) : super(key: key);

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232323),
      body: CustomScrollView(
        slivers: [
          const Appbar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 250
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return IngredientsApi(index);

                },
                childCount: 1,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
