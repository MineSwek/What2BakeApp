import 'package:flutter/material.dart';
import 'package:what2bake/widgets/recipes-body.dart';

class Recipes extends StatefulWidget {
  const Recipes({super.key});

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF232323),
      body: RecipesBody(),
    );
  }
}

