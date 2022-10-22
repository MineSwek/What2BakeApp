import 'package:flutter/material.dart';
import 'package:what2bake/widgets/appbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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
