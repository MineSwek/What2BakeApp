import 'package:flutter/material.dart';
import 'package:what2bake/widgets/appbar.dart';

class Ingredients extends StatefulWidget {
  const Ingredients({Key? key}) : super(key: key);

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {



  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF232323),
      body: CustomScrollView(
        slivers: [
          Appbar()
        ],
      ),
    );
  }
}
