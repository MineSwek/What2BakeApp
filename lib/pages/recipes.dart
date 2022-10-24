import 'package:flutter/material.dart';
import 'package:what2bake/services/recipes-api.dart';
import 'package:what2bake/widgets/appbar.dart';

class Recipes extends StatefulWidget {
  const Recipes({Key? key}) : super(key: key);

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF232323),
      body: CustomScrollView(
        slivers: [
          Appbar(),
          RecipesApi(),
        ],
      ),
    );
  }
}
